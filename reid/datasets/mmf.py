import os
import itertools
import  re
import glob

class MMF:
    def __init__(self, root, camstyle_path=None, total_cv_folds=11, cv_fold=0):

        assert camstyle_path is not None

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
        return preprocessed_fnames, len(preprocessed_fnames)
            
        
    def load(self):
        file_names = self.parse_names(sorted(glob.glob(os.path.join(self.images_dir, "*", "*", "*.*"))))
        
        self.train, self.num_train_ids = self.preprocess(file_names, None, self.train_ids, True)
        self.gallery, self.num_gallery_ids = self.preprocess(file_names, self.gallery_cams, self.test_ids, False)
        self.query, self.num_query_ids = self.preprocess(file_names, self.probe_cams, self.test_ids, False)

        camstyle_fnames = self.parse_names(sorted(glob.glob(os.path.join(self.camstyle_path, "*.*"))))
        self.camstyle, self.num_camstyle_ids = self.preprocess(camstyle_fnames, None, self.train_ids, True)
