from collections import namedtuple
from typing import Callable


Card = namedtuple('Card', ['symbol', 'seed'])


def create_deck(symbols: list, seeds: list = None):
    """
    Creazione del mazzo
    - inizializzo una lista vuota
    - input: simboli e tutti i semi
    - combinarli (prodotto cartesiano)
    - riempio la lista
    - output: lista
    :param symbols: list of card symbols
    :param seeds: list of card seeds
    :return: list of cards as named tuples
    """
    if seeds is None:
        seeds = ['C', 'Q', 'F', 'P']
    deck = []
    for symbol in symbols:
        for seed in seeds:
            card = Card(symbol=symbol, seed=seed)
            deck.append(card)
    return deck


def create_decks(
        symbols: list,
        seeds: list = None,
        num: int = 1,
        how_to: Callable = create_deck):
    deck = []
    for i in range(num):
        d = how_to(symbols=symbols, seeds=seeds)
        deck.extend(d)
    return deck



