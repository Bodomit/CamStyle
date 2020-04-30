import os
import argparse
import re
import glob
import shutil

from typing import Set

from reid.datasets.mmf import MMF

MIN_ID = 1
MAX_ID = 77

def main(directory: str, dry_run: bool):
    mmf = MMF(directory)

    imgs_to_keep: Set[str] = set()
    for image in mmf.query + mmf.gallery:
        imgs_to_keep.add(image[0])

    pattern = os.path.join(directory, "**/*.png")
    all_images = set(glob.glob(pattern, recursive=True))

    images_to_delete = all_images - imgs_to_keep

    print("All images: {}".format(len(all_images)))
    print("Images to keep: {}".format(len(imgs_to_keep)))
    print("Images to delete: {}".format(len(images_to_delete)))

    if not dry_run:
        for dir in images_to_delete:
            shutil.rmtree(dir, ignore_errors=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("directory", metavar="DIR")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    main(args.directory, args.dry_run)