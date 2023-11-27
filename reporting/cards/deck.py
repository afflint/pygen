import itertools
import numpy as np
from typing import List


class Card:
    def __init__(self, symbol: str, seed: str):
        self.symbol = symbol
        self.seed = seed

    def __repr__(self):
        return "{}-{}".format(self.symbol, self.seed)

    def value(self) -> int:
        try:
            return int(self.symbol)
        except ValueError:
            return 10


class BlackJackCard(Card):
    def __init__(self, symbol: str, seed: str):
        super().__init__(symbol, seed)
        if not self.check_symbol():
            raise ValueError(
                    '{} is not a valid blackjack card'.format(
                        self.symbol)
                )

    def check_symbol(self):
        try:
            if int(self.symbol) in range(2, 11):
                return True
            else:
                return False
        except ValueError:
            if self.symbol in ['A', 'J', 'Q', 'K']:
                return True
            else:
                return False

    def value(self) -> int:
        try:
            if int(self.symbol) in range(2, 11):
                return int(self.symbol)
        except ValueError:
            if self.symbol == 'A':
                return 11
            elif self.symbol in ['J', 'Q', 'K']:
                return 10
            else:
                raise ValueError(
                    '{} is not a valid blackjack card'.format(
                        self.symbol)
                )


class BlackJackDeck:
    def __init__(self):
        self.cards = []
        self.symbols = [str(x) for x in range(2, 11)] + ['A', 'J', 'K', 'Q']
        self.seeds = ['C', 'Q', 'F', 'P']
        self.create()

    def create(self):
        for symbol, seed in itertools.product(self.symbols, self.seeds):
            self.cards.append(BlackJackCard(symbol, seed))

    def shuffle(self):
        np.random.shuffle(self.cards)

    def deal(self, num: int = 1) -> List[BlackJackCard]:
        hand = []
        for i in range(num):
            try:
                card = self.cards.pop()
            except IndexError:
                self.create()
                card = self.cards.pop()
            hand.append(card)
        return hand

    def distribute(self, num_hands: int = 1, num_cards: int = 1) -> List[List[BlackJackCard]]:
        hands = []
        for i in range(num_hands):
            hand = self.deal(num=num_cards)
            hands.append(hand)
        return hands




