#!/usr/bin/env python3

import os
import re
import logging
import argparse


logging.basicConfig(level=logging.INFO)

log = logging.getLogger(__name__)


class Pattern:
    def __init__(self, prefix, extension, destination):
        self.prefix = prefix
        self.extension = extension
        self.destination = destination

    def matched(self, filename):
        return filename.startswith(self.prefix) and filename.endswith(self.extension)


PATTERNS = [
    Pattern("concert-", "pdf", "Concerts"),
    Pattern("avia-", "pdf", "Avia"),
    Pattern("train-", "pdf", "Train"),
    Pattern("booking-", "pdf", "Booking"),
    Pattern("conference-", "pdf", "Conference"),
]


def iter_directory_files(directory):
    for filename in os.listdir(directory):
        yield os.path.join(directory, filename)


def apply_pattern(filename, pattern, destination_dir):
    basename = os.path.basename(filename)
    name = basename.replace(pattern.prefix, "")
    destination = os.path.join(destination_dir, pattern.destination, name)

    log.info("move file %s to %s", filename, destination)
    os.rename(filename, destination)


def move_files(source_dir, destination_dir):
    for filename in iter_directory_files(source_dir):
        for pattern in PATTERNS:
            if pattern.matched(os.path.basename(filename)):
                apply_pattern(filename, pattern, destination_dir)
                break


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("--source-dir", required=True)
    parser.add_argument("--destination-dir", required=True)

    return parser.parse_args()


def main(args):
    return move_files(args.source_dir, args.destination_dir)


if __name__ == "__main__":
    exit(main(parse_args()))
