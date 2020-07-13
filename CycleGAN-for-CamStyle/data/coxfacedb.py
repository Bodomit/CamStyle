import os.path
import csv
from data.base_dataset import BaseDataset, get_transform
from data.image_folder import make_dataset
from PIL import Image
import random


class CoxFaceDB(BaseDataset):
    def initialize(self, opt):
        self.opt = opt
        self.root = opt.dataroot

        self.partition_dir = opt.coxfacedb_partition_dir
        self.partition = opt.coxfacedb_partition

        self.train_partition, self.test_partition = self.get_partitions()

        self.dir_A = os.path.join(opt.dataroot, opt.camA)
        self.dir_B = os.path.join(opt.dataroot, opt.camB)

        self.A_paths = make_dataset(self.dir_A)
        self.B_paths = make_dataset(self.dir_B)

        self.A_paths = self.filter(self.A_paths, opt.isTrain)
        self.B_paths = self.filter(self.B_paths, opt.isTrain)

        self.A_paths = sorted(self.A_paths)
        self.B_paths = sorted(self.B_paths)
        self.A_size = len(self.A_paths)
        self.B_size = len(self.B_paths)
        self.transform = get_transform(opt)

        self.fname_pattern = r"(\d+)_(\d+|frontal).+[.jpg|.JPG]$"

    def __getitem__(self, index):
        A_path = self.A_paths[index % self.A_size]
        if self.opt.serial_batches:
            index_B = index % self.B_size
        else:
            index_B = random.randint(0, self.B_size - 1)
        B_path = self.B_paths[index_B]
        # print('(A, B) = (%d, %d)' % (index_A, index_B))
        A_img = Image.open(A_path).convert('RGB')
        B_img = Image.open(B_path).convert('RGB')

        A = self.transform(A_img)
        B = self.transform(B_img)
        if self.opt.which_direction == 'BtoA':
            input_nc = self.opt.output_nc
            output_nc = self.opt.input_nc
        else:
            input_nc = self.opt.input_nc
            output_nc = self.opt.output_nc

        if input_nc == 1:  # RGB to gray
            tmp = A[0, ...] * 0.299 + A[1, ...] * 0.587 + A[2, ...] * 0.114
            A = tmp.unsqueeze(0)

        if output_nc == 1:  # RGB to gray
            tmp = B[0, ...] * 0.299 + B[1, ...] * 0.587 + B[2, ...] * 0.114
            B = tmp.unsqueeze(0)
        return {'A': A, 'B': B,
                'A_paths': A_path, 'B_paths': B_path}

    def __len__(self):
        return max(self.A_size, self.B_size)

    def name(self):
        return 'CoxFaceDB'

    def get_partitions(self):
        sub_id_list_path = os.path.join(self.partition_dir, "sub_id_list.csv")

        sub_ids = []
        with open(sub_id_list_path, "rt") as infile:
            reader = csv.reader(infile)
            for row in reader:
                sub_ids.append(row[0])

        test_sub_partitons = []
        test_list_path = os.path.join(self.partition_dir, "test_sub_list.csv")
        with open(test_list_path, "rt") as infile:
            reader = csv.reader(infile)
            for row in reader:
                test_sub_partitons.append(row)

        train_sub_partitons = []
        train_list_path = os.path.join(
            self.partition_dir, "train_sub_list.csv")
        with open(train_list_path, "rt") as infile:
            reader = csv.reader(infile)
            for row in reader:
                train_sub_partitons.append(row)

        test_partition_idxs = test_sub_partitons[self.partition]
        train_partition_idxs = train_sub_partitons[self.partition]

        test_partition_ids = [sub_ids[int(i)-1] for i in test_partition_idxs]
        train_partition_ids = [sub_ids[int(i)-1] for i in train_partition_idxs]

        return train_partition_ids, test_partition_ids

    def filter(self, paths, is_train):
        # Only filter on training as we want fakes for both test and train
        # sets when generating.

        if not is_train:
            return paths

        partition = self.train_partition if is_train else self.test_partition

        filtered_paths = []
        for path in paths:
            pid = os.path.basename(path).split("_")[0]
            if pid in partition:
                filtered_paths.append(path)

        return filtered_paths
