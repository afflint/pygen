import pandas as pd


def read_csv(file_path):
    metadata = pd.read_csv(file_path)
    return metadata