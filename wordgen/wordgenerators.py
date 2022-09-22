import numpy as np


START_CHAR = "#S"
END_CHAR = "#E"


class DummyWordGenerator(object):

    def __init__(self, alphabet: str, upper_bound: int = 10**3):
        """
        Class for generating words in a dummy way
        :param alphabet: a string containing the alphabet
        """
        self.alpha = list(alphabet)
        self.alpha = self.alpha + [END_CHAR]
        self.upper =  upper_bound

    def choose(self, p=None):
        if p is not None:
            return np.random.choice(self.alpha, size=1, p=p)[0]
        else:
            return np.random.choice(self.alpha, size=1)[0]

    def generate(self, prefix: str = "", p=None) -> str:
        """
        Generator of words
        :param prefix: First letters of word without START CHAR
        :return: string of generated word
        """
        word = prefix
        for i in range(self.upper):
            c = self.choose(p=p)
            word += c
            if c == END_CHAR:
                break
        return word[:-len(END_CHAR)]
