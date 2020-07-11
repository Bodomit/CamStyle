import os.path
import glob
from data.base_dataset import BaseDataset, get_transform
from PIL import Image
import random

G1 = set([
        "P1E_S1_C1",
        "P1E_S2_C2",
        "P2E_S2_C2",
        "P2E_S1_C3",
        "P1L_S1_C1",
        "P1L_S2_C2",
        "P2L_S2_C2",
        "P2L_S1_C1",
    ])

G2 = set([
        "P1E_S3_C3",
        "P1E_S4_C1",
        "P2E_S4_C2",
        "P2E_S3_C1",
        "P1L_S3_C3",
        "P1L_S4_C1",
        "P2L_S4_C2",
        "P2L_S3_C3",
    ])


class ChokePoint(BaseDataset):

    def initialize(self, opt):
        self.opt = opt
        self.root = opt.dataroot
        self.camA = opt.camA
        self.camB = opt.camB
        self.fname_pattern = r"(C\d)/(\d+)/\d+.png$"

        self.all_paths = self.__all_samples(opt.isTrain)

        self.A_paths = [p[0] for p in self.all_paths if p[3] == self.camA]
        self.B_paths = [p[0] for p in self.all_paths if p[3] == self.camB]

        self.A_paths = sorted(self.A_paths)
        self.B_paths = sorted(self.B_paths)

        self.A_size = len(self.A_paths)
        self.B_size = len(self.B_paths)
        self.transform = get_transform(opt)

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
        return 'UnalignedDataset'

    def directory(self, dataroot, phase, cam):
        path = dataroot
        if phase:
            path = os.path.join(dataroot, phase)
        if cam:
            path = os.path.join(path, cam)
        return path

    def __all_samples(self, is_training):
        path_pattern = os.path.join(self.root, "*", "*", "*.png")
        all_paths = glob.glob(path_pattern)

        parsed_paths = set()
        for path in all_paths:
            splits = path.split(os.path.sep)

            if is_training and splits[-3] not in G1:
                continue

            pid = splits[-2]
            portal, session, cam = splits[-3].split("_")
            parsed_paths.add((path, portal, session, cam, pid))
        return parsed_paths
