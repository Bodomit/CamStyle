import os
import itertools
import re
import glob
import collections
import random

class MMF:
    def __init__(self, root, camstyle_path=None, total_cv_folds=11, cv_fold=0):
        
        self.total_cv_folds = total_cv_folds
        self.cv_fold = cv_fold

        self.images_dir = os.path.join(root)
        self.camstyle_path = camstyle_path
        
        self.gallery_cams = ["A", "B", "C"]
        self.probe_cams = ["1", "2", "3"]

        self.train_ids, self.test_ids = self.get_cv_ids()

        self.train, self.query, self.gallery, self.camstyle = [], [], [], []
        self.num_train_ids, self.num_query_ids, self.num_gallery_ids, self.num_camstyle_ids = 0, 0, 0, 0
        self.load()

        self.query = self.limit(self.query)
        self.gallery = self.limit(self.gallery)

    def get_cv_ids(self, total_cv_folds=11, cv_fold=0, total_ids=77):

        assert cv_fold < total_cv_folds
        
        allocated = 0
        ids_per_split = [[] for  _ in range(total_cv_folds)]
        for i in range(1, total_ids + 1):
            if allocated == total_ids:
                break
            else:
                ids_per_split[i % total_cv_folds].append("{0:03d}".format(i))
                allocated += 1
        
        test = ids_per_split[cv_fold]
        ids_per_split.remove(test)
        train = sorted(list(itertools.chain.from_iterable(ids_per_split)))

        return train, test

    def parse_names(self, f_names):
        pattern = re.compile(r"(\d{3})_(\d|\w)_(\d{5})")
        parsed_fnames = []
        for f_name in f_names:
            pid, cam, _ = pattern.search(f_name).groups()
            parsed_fnames.append((f_name, pid, cam))
        return parsed_fnames

    def preprocess(self, f_names, cams, ids, relabel=True):
        preprocessed_fnames = []

        all_pids = {}
        for f_name in f_names:
            pid = f_name[1]
            cam = f_name[2]
            if (ids is None or pid in ids) and (cams is None or cam in cams):

                if relabel:
                    if pid not in all_pids:
                        all_pids[pid] = len(all_pids)
                else:
                    if pid not in all_pids:
                        all_pids[pid] = pid
                pid = all_pids[pid]
                preprocessed_fnames.append((f_name[0], pid, cam))
        return preprocessed_fnames, len(all_pids), all_pids
            
    def load(self):
        file_names = self.parse_names(sorted(glob.glob(os.path.join(self.images_dir, "*", "*", "*.*"))))
        
        self.train, self.num_train_ids, self.train_pids_map = self.preprocess(file_names, None, self.train_ids, True)
        self.gallery, self.num_gallery_ids, _ = self.preprocess(file_names, self.gallery_cams, self.test_ids, False)
        self.query, self.num_query_ids, _ = self.preprocess(file_names, self.probe_cams, self.test_ids, False)

        if self.camstyle_path is not None:
            camstyle_fnames = self.parse_names(sorted(glob.glob(os.path.join(self.camstyle_path, "*.*"))))
            self.camstyle, self.num_camstyle_ids, _ = self.preprocess(camstyle_fnames, None, self.train_ids, True)
            self.assert_ids()
        else:
            self.camstyle = None
            self.num_camstyle_ids = None

    def assert_ids(self):
        train_ids = set([pid for _, pid, _ in self.train])
        gallery_ids = set([pid for _, pid, _ in self.gallery])
        query_ids = set([pid for _, pid, _ in self.query])

        assert gallery_ids == set(self.test_ids)

        assert gallery_ids == query_ids
        assert not any([gid in self.train_pids_map for gid in gallery_ids])

    def limit(self, dataset, limit=10, seed=42):
        random.seed(seed)

        files_per_cam_pid = collections.defaultdict(list)
        for filename, pid, cam in dataset:
            files_per_cam_pid[(pid, cam)].append(filename)

        limited_dataset = []
        for pid, cam in files_per_cam_pid:
            files = random.choices(files_per_cam_pid[(pid, cam)], k=limit)
            limited_dataset.extend([(f, pid, cam) for f in files])

        return limited_dataset


class MMFIndiCam(MMF):
    
    MIN_ID = 1
    MAX_ID = 77
    CAMS = ["1", "2", "3", "A", "B", "C"]

    def __init__(self, *args, **kwargs):
        super(MMFIndiCam, self).__init__(*args, **kwargs)
        self.cam_for_pid = self.get_cams_for_pid()
        self.train = self.postprocess(self.train, self.cam_for_pid)
        self.assert_ids()

    def get_cams_for_pid(self):
        cam_for_pid = {}

        for id in range(self.MIN_ID, self.MAX_ID):
            cam = self.CAMS[(id - self.MIN_ID) % len(self.CAMS)]

            try:
                relabled_pid = self.train_pids_map["{0:03d}".format(id)]
                cam_for_pid[relabled_pid] = cam
            except KeyError:
                continue

        return cam_for_pid
        
    def postprocess(self, training_set, cam_for_pid):
        filtered = []
        for f_name, pid, cam in training_set:
            if cam_for_pid[pid] == cam:
                filtered.append((f_name, pid, cam))
        return filtered

class MMFIndiCam10(MMFIndiCam):
    def __init__(self, *args, **kwargs):
        super(MMFIndiCam10, self).__init__(*args, **kwargs)
        self.train = self.postprocess2(self.train)
        self.assert_ids()

    def postprocess2(self, training_set):
        mmf_indicam_10_path = os.path.join(os.path.dirname(self.images_dir), "mmf6-indicam-10")
        mmf_indicam_10_files = set(glob.glob(os.path.join(mmf_indicam_10_path, "*", "*", "*.*")))
        mmf_indicam_10_files = set([os.path.basename(f) for f in mmf_indicam_10_files])

        postprocessed = []

        filtered = []
        for f_name, pid, cam in training_set:
            if os.path.basename(f_name) in mmf_indicam_10_files:
                filtered.append((f_name, pid, cam))

        return filtered

class MMFPairs(MMF):
    MIN_ID = 1
    MAX_ID = 77
    PAIRS = [("1", "A"), ("2", "B"), ("3", "C")]

    def __init__(self, *args, **kwargs):
        super(MMFPairs, self).__init__(*args, **kwargs)
        self.cam_for_pid = self.get_cams_for_pid()
        self.train = self.postprocess(self.train, self.cam_for_pid)
        self.assert_ids()

    def get_cams_for_pid(self):
        cam_for_pid = {}

        for id in range(self.MIN_ID, self.MAX_ID):
            pair = self.PAIRS[(id - self.MIN_ID) % len(self.PAIRS)]
            for cam in pair:
                try:
                    relabled_pid = self.train_pids_map["{0:03d}".format(id)]
                    cam_for_pid[relabled_pid] = cam
                except KeyError:
                    continue

        return cam_for_pid
        
    def postprocess(self, training_set, cam_for_pid):
        filtered = []
        for f_name, pid, cam in training_set:
            if cam_for_pid[pid] == cam:
                filtered.append((f_name, pid, cam))
        return filtered


class MMFPairs10(MMFPairs):
    def __init__(self, *args, **kwargs):
        super(MMFPairs10, self).__init__(*args, **kwargs)
        self.train = self.postprocess2(self.train)
        self.assert_ids()

    def postprocess2(self, training_set):
        mmf_pairs_10_path = os.path.join(os.path.dirname(self.images_dir), "mmf6-pairs-10")
        mmf_pairs_10_files = set(glob.glob(os.path.join(mmf_pairs_10_path, "*", "*", "*.*")))
        mmf_pairs_10_files = set([os.path.basename(f) for f in mmf_pairs_10_files])

        postprocessed = []

        filtered = []
        for f_name, pid, cam in training_set:
            if os.path.basename(f_name) in mmf_pairs_10_files:
                filtered.append((f_name, pid, cam))

        return filtered