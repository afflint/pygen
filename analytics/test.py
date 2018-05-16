# -*- coding: utf-8 -*-
__project__ = 'analytics'
__author__ = 'Alfio Ferrara'
__email__ = 'alfio.ferrara@unimi.it'
__institution__ = 'Università degli Studi di Milano'
__date__ = '17 mag 2018'
__comment__ = '''
        Simple example of using test units
    '''
import unittest
import numpy as np


class MyMath(object):

    @staticmethod
    def sum(numbers):
        s = 0
        for n in numbers:
            s += n
        return s

    @staticmethod
    def prod(numbers):
        s = 1
        for n in numbers:
            s *= n
        return s


class TestMyMath(unittest.TestCase):

    def test_operations(self):
        n = np.random.sample(200)
        self.assertEqual(MyMath.sum(n), np.array(n).sum())  # See equality error
        self.assertEqual(MyMath.prod(n), np.array(n).prod())
        # CORRECT
        # self.assertTrue(np.isclose(MyMath.sum(n), np.array(n).sum()))
        # self.assertTrue(np.isclose(MyMath.prod(n), np.array(n).prod()))

    def test_zeros(self):
        n = np.zeros(200)
        self.assertTrue(MyMath.sum(n) == 0 and MyMath.prod(n) == 0)
        self.assertFalse(MyMath.sum(n) != MyMath.prod(n))

    def test_types(self):
        n = list(np.zeros(200)) + ['A']
        with self.assertRaises(ValueError):  # See the Exception error
#        with self.assertRaises(TypeError):  # CORRECT
            MyMath.sum(n)
            MyMath.prod(n)

if __name__ == '__main__':
    unittest.main()
