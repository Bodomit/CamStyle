import os
from options.test_options import TestOptions
from data import CreateDataLoader
from models import create_model
from util.visualizer import save_images
from util import html


if __name__ == '__main__':
    opt = TestOptions().parse()
    opt.nThreads = 0 if opt.debug else 1    # test code only supports nThreads = 1
    opt.batchSize = 1  # test code only supports batchSize = 1
    opt.serial_batches = True  # no shuffle
    opt.no_flip = True  # no flip
    opt.display_id = -1  # no visdom display
    opt.loadSize = 256
    opt.fineSize = 256
    data_loader = CreateDataLoader(opt)
    dataset = data_loader.load_data()
    model = create_model(opt)
    model.setup(opt)
    # test
    for i, data in enumerate(dataset):
        # if i >= opt.how_many:
            # break
        model.set_input(data)
        model.test()
        visuals = model.get_current_visuals()
        if i % 5 == 0:
            print('processing (%04d)-th image.' % (i))
        for img_path in set.union(set(data["A_paths"]), set(data["B_paths"])):
            save_images(visuals, [img_path], opt.camA, opt.camB, opt.save_root,
                        fname_pattern=dataset.dataset.fname_pattern)
