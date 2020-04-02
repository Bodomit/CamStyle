#!/usr/bin/env python3

import os
import glob
import argparse
import shutil
import re

from itertools import groupby, islice
from collections import defaultdict
from typing import Dict, List, Set, Tuple


def main(directory: str, n: int):

    image_paths = os.path.join(directory, "**/*.png")
    all_images = set(glob.glob(image_paths, recursive=True))
    images_to_keep : Set[str] = set()

    for _, g in groupby(sorted(all_images), key=lambda x:os.path.dirname(x)):
        images_to_keep.update(islice(g, 10))

    images_to_delete = all_images - images_to_keep

    print("Total Images: {}".format(len(all_images)))
    print("Images to keep: {}".format(len(images_to_keep)))
    print("Paths to delete: {}".format(len(images_to_delete)))

    for path in images_to_delete:
        os.remove(path)

    print("Complete!")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("directory", metavar="DIR")
    parser.add_argument("--num", "-n", metavar="INT", default=10)
    args = parser.parse_args()
    main(args.directory, int(args.num))