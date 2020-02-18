import os
import itertools
import re
import glob
import pickle

CAMERA_AZIMUTHS = [180, 210, 240, 270, 300, 330, 0]
CAMERA_ZENITHS = [45, 60, 75, 90]

class VGGFace2:
    def init(self, root, camstyle_path=None, gallery_seed=42, angles_path=None):
        
        assert camstyle_path  is not None
        assert angles_path is not None

        self.root = root
        self.train_path = "train"
        self.test_path = "test"

        self.angles_path = angles_path
        self.camstyle_path = camstyle_path

        self.train, self.query, self.gallery, self.camstyle = [], [], [], []
        self.num_train_ids, self.num_query_ids, self.num_gallery_ids, self.num_camstyle_ids = 0, 0, 0, 0
        self.load()

    def load_headpose(self):
        print("Loading headpose data for VGGFace2: this may take a while...")
        with open(os.path.join(self.angles_path), "rb") as input_file:
            self.headpose = pickle.load(input_file)

    def parse_names(self, f_names):
        pattern = re.compile(r"(\d+)" + os.path.sep + r"(?:\d+).jpg$")
        parsed_fnames = []
        for f_name in f_names:
            pid = pattern.search(f_name).groups()
            parsed_fnames.append((f_name, pid))
        return parsed_fnames

    def preprocess(self, path, relabel=True):

        f_names = sorted(glob.glob(os.path.join(self.root, path, "*", "*.*")))

        preprocessed_fnames = []
        all_pids = {}
        for f_name in f_names:
            pid = f_name[1]
        
            if relabel:
                if pid not in all_pids:
                    all_pids[pid] = len(all_pids)
            else:
                if pid not in all_pids:
                    all_pids[pid] = pid
            pid = all_pids[pid]

            preprocessed_fnames.append((f_name[0], pid, None))
        return preprocessed_fnames, len(preprocessed_fnames)

    def load(self):
        self.load_headpose()

        self.train, self.num_train_ids = self.preprocess(self.train_path)
        self.test, self.num_test_ids = self.preprocess(self.test_path)
        self.camstyle, self.num_camstyle_ids = self.preprocess(self.camstyle_path)

        self.num_query_ids = self.num_gallery_ids = self.num_test_ids

        #self.gallery, self.query = self.gallery_and_probe()

        