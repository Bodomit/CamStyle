import os
import re
import argparse
import glob
import itertools
import shutil
import pickle

from tqdm import tqdm
from typing import List, Set, Tuple


DEFAULT_DATASETS_PATH = os.path.expanduser(
    os.path.join("~", "datasets"))


CAM_AZIMUTHS = [0, 180, 210, 240, 270, 300, 330]
CAM_ZENITHS = [45, 60, 75, 90]


def parse_filenames(filenames: List[str]):
    pattern = r"(train|test)/\d+/(\d+)_\w_(\d+)_(\d+)_\d+.png$"
    for filename in filenames:
        match = re.match(pattern, filename)
        assert match

        phase, pid, azimuth, zenith = match.groups()
        yield filename, str(phase), str(pid), int(azimuth), int(zenith)


def main(input_path: str, output_path: str, filenames_path: str):
    if filenames_path:
        with open(filenames_path, "rb") as infile:
            filenames = pickle.load(infile)
    else:
        filenames = glob.glob(os.path.join(input_path, "*", "*", "*.png"))
        filenames = [os.path.relpath(f, input_path) for f in filenames]

    cams = set(itertools.product(CAM_AZIMUTHS, CAM_ZENITHS))
    cams_to_labels = dict(zip(sorted(cams), range(len(cams))))

    for parsed in tqdm(parse_filenames(filenames), total=len(filenames)):
        filename, phase, pid, azimuth, zenith = parsed

        new_path = os.path.join(output_path,
                                phase,
                                str(cams_to_labels[(azimuth, zenith)]),
                                pid,
                                os.path.basename(filename)
                                )

        os.makedirs(os.path.dirname(new_path), exist_ok=True)

        shutil.copyfile(os.path.join(input_path, filename),
                        os.path.join(new_path))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", "-i", metavar="DIR",
                        default=os.path.join(DEFAULT_DATASETS_PATH, "synth"))
    parser.add_argument("--output", "-o", metavar="DIR",
                        default=os.path.join(
                            DEFAULT_DATASETS_PATH, "synthpose"))
    parser.add_argument("--filenames-path",
                        default=os.path.join(
                            DEFAULT_DATASETS_PATH, "synth", "filenames.pickle")
                        )
    args = parser.parse_args()
    main(args.input, args.output, args.filenames_path)
