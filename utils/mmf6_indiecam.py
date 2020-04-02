import os
import glob
import argparse
import shutil
import re

from collections import defaultdict
from typing import Dict, List, Set

MIN_ID = 1
MAX_ID = 77
CAMS = ["1", "2", "3", "A", "B", "C"]

def main(directory: str):

    dirs_to_keep: Set[str] = set()
    for id in range(MIN_ID, MAX_ID):
        cam = CAMS[(id - MIN_ID) % len(CAMS)]
        dirs_to_keep.add(os.path.join(directory, cam, "{:03d}/".format(id)))

    path = os.path.join(directory, "**/")
    all_dirs = set(glob.glob(path, recursive=True))
    id_dirs = set([d for d in all_dirs if re.search(r"/[\w\d]/\d{3}/", d)])

    dirs_to_delete = id_dirs - dirs_to_keep

    print("Paths to keep: {}".format(len(dirs_to_keep)))
    print("Id paths: {}".format(len(id_dirs)))
    print("Paths to delete: {}".format(len(dirs_to_delete)))

    for dir in dirs_to_delete:
        shutil.rmtree(dir, ignore_errors=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("directory", metavar="DIR")
    args = parser.parse_args()
    main(args.directory)