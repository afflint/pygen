class Card:
    def __init__(self, symbol: str, seed: str):
        self.symbol = symbol
        self.seed = seed

    def __repr__(self):
        return "{} - {}".format(self.symbol, self.seed)

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



class Deck:
    def __init__(self, name):
        self.a = name
