from __future__ import absolute_import
from .duke import Duke
from .market import Market
from .mmf import MMF
from .vggface2 import VGGFace2


__factory = {
    'market': Market,
    'duke': Duke,
    'mmf6': MMF,
    'vggface2': VGGFace2
}


def names():
    return sorted(__factory.keys())


def create(name, root, *args, **kwargs):
    """
    Create a dataset instance.

    Parameters
    ----------
    name : str
        The dataset name. Can be one of 'market', 'duke'.
    root : str
        The path to the dataset directory.
    """
    if name not in __factory:
        raise KeyError("Unknown dataset:", name)
    return __factory[name](root, *args, **kwargs)
