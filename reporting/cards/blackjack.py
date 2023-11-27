from .deck import BlackJackDeck
from abc import abstractmethod


class Player:
    def __init__(self, initial_capital: float = 100):
        self.capital = initial_capital
        self.status_in_game = True
        self.status_stay = False
        self.hand = []

    def value_hand(self) -> int:
        return sum(x.value() for x in self.hand)

    def stay(self):
        self.status_stay = True

    def hit(self, deck: BlackJackDeck):
        card = deck.deal(num=1)[0]
        self.hand.append(card)
        if self.value_hand() > 21:
            self.status_in_game = False

    @abstractmethod
    def play(self):
        pass


class HumanPlayer(Player):
    def __init__(self, name: str, initial_capital: float = 100):
        super().__init__(initial_capital=initial_capital)
        self.name = name

    def play(self, deck: BlackJackDeck):
        for i in range(1000):
            if self.status_stay:
                break
            if not self.status_in_game:
                break
            prompt = "Actual value: {}\t".format(self.value_hand())
            user_input = input(prompt)
            if user_input == 'hit':
                self.hit(deck)
            elif user_input == 'stay':
                self.stay()
            else:
                print("Choose hit or stay")

