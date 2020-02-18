
import os
import csv
import re
import glob

from typing import Dict, Tuple, List


class VGGFace2Pose:
    def __init__(self, root, camstyle_path=None, test_set=False,
                 cameras_csv_path="cameras.csv",
                 azimuths=None, zeniths=None):

        assert camstyle_path is not None
        assert cameras_csv_path is not None

        self.images_dir = os.path.join(root)
        self.camstyle_path = camstyle_path

        self.cameras_csv_path = os.path.join(root, cameras_csv_path)
        self.cameras = self._read_camera_csv(self.cameras_csv_path)

        self.valid_camera_labels = self._filter_camera_labels(
            self.cameras, azimuths, zeniths
        )

        self.train, self.query, self.gallery, self.camstyle = [], [], [], []
        self.num_train_ids = 0
        self.num_query_ids = 0
        self.num_gallery_ids = 0
        self.num_camstyle_ids = 0

        self.load()

    def _read_camera_csv(self, cameras_csv_path: str) \
            -> Dict[int, Tuple[int, int]]:
        camera_labels: Dict[int, Tuple[int, int]] = {}
        with open(cameras_csv_path, "r") as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                azimuth = int(row["Azimuth"])
                zenith = int(row["Zenith"])
                camera_labels[int(row["Label"])] = (azimuth, zenith)
        return camera_labels

    def _filter_camera_labels(self, cameras: Dict[int, Tuple[int, int]],
                              azimuths: List[int],
                              zeniths: List[int]) -> List[int]:
        filtered_cameras = [c for c in cameras if cameras[c][0] in azimuths]
        filtered_cameras = [c for c in filtered_cameras
                            if cameras[c][1] in zeniths]
        return filtered_cameras

    def _parse_names(self, f_names: List[str]) -> List[Tuple[str, str, int]]:
        pattern = re.compile(r"(\d+)" + os.path.sep +
                             r"(\w+)" + os.path.sep +
                             r"(?:\d+).jpg$")
        parsed_fnames = []
        for f_name in f_names:
            match = pattern.search(f_name)
            assert match
            cam, pid = match.groups()
            parsed_fnames.append((f_name, pid, int(cam)))
        return parsed_fnames

    def _preprocess(self,
                    parsed_filenames: List[Tuple[str, str, int]],
                    valid_cams: List[int],
                    relabel: bool) -> Tuple[List[Tuple[str, str, int]], int]:
        preprocessed_fnames = []

        all_pids: Dict[str, str] = {}
        for f_name, pid, cam in parsed_filenames:
            if valid_cams is None or cam in valid_cams:
                if pid not in all_pids:
                    label = str(len(all_pids)) if relabel else pid
                    all_pids[pid] = label
                pid = all_pids[pid]
                preprocessed_fnames.append((f_name[0], pid, cam))
        return preprocessed_fnames, len(preprocessed_fnames)

    def _parse_and_preprocess(self,
                              filenames: List[str],
                              valid_cams: List[int],
                              relabel: bool) \
            -> Tuple[List[Tuple[str, str, int]], int]:

        parsed_filenames = self._parse_names(filenames)
        dataset, n_dataset = self._preprocess(
            parsed_filenames, valid_cams, relabel)
        return dataset, n_dataset

    def _gallery_and_query(self) -> Tuple[List[str], List[str]]:
        raise NotImplementedError("Do this...")

    def load(self):
        train_file_names = glob.glob(
            os.path.join(self.images_dir, "train", "*", "*", "*.*"))
        train_file_names = sorted(train_file_names)

        self.train, self.num_train_ids = self._parse_and_preprocess(
            train_file_names, self.valid_camera_labels, True)

        gallery_filenames, query_filenames = self._gallery_and_query()

        self.gallery, self.num_gallery_ids = self._parse_and_preprocess(
            gallery_filenames, self.valid_camera_labels, False)
        self.query, self.num_query_ids = self._parse_and_preprocess(
            query_filenames, self.valid_camera_labels, False)

        camstyle_fnames = glob.glob(os.path.join(self.camstyle_path, "*.*"))
        camstyle_fnames = sorted(camstyle_fnames)

        self.camstyle, self.num_camstyle_ids = self._parse_and_preprocess(
            camstyle_fnames, None, True)
