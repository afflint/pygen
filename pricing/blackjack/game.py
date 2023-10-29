from typing import List

from blackjack.deck import Deck
import abc


class Player:
    def __init__(self, name: str):
        self.name = name
        self.hand = []
        self.hand_value = 0
        self.in_game = True

    def compute_value(self):
        self.hand_value = sum(card.value for card in self.hand)

    def hit(self, deck: Deck):
        self.hand.extend(deck.deal(num=1))
        self.compute_value()

    def stay(self):
        self.in_game = False

    @abc.abstractmethod
    def play(self, deck: Deck):
        pass


class Dealer(Player):
    def play(self, deck: Deck):
        if self.hand_value <= 16:
            self.hit(deck)
        elif 16 < self.hand_value <= 21:
            self.stay()
        else:
            self.in_game = False


class HumanPlayer(Player):
    def __init__(self, name: str, capital: float, bet_rate: float = 2.00):
        super().__init__(name)
        self.capital = capital
        self.bet_rate = bet_rate

    def play(self, deck: Deck):
        if self.hand_value <= 21:
            action = input('{}: {} - hit or stay'.format(
                self.name,
                self.hand_value
            ))
            if action == 'hit':
                self.hit(deck)
            else:
                self.stay()
        else:
            self.in_game = False

    def bet(self, money: float = None):
        if money is None:
            money = self.bet_rate
        self.capital -= money
        return money


class Table:
    def __init__(self):
        self.deck = Deck.create_basic_deck()
        self.deck.shuffle()
        self.players = []
        self.dealer = Dealer(name='Dealer')
        self.bets = {}

    def add_player(self, player: HumanPlayer):
        self.players.append(player)

    def receive_bets(self, money: List[float]):
        for player in self.players:
            self.bets[player.name] = player.bet()

    def serve_players(self):
        for player in self.players:
            player.hand.extend(self.deck.deal(num=2))
            player.compute_value()
        self.dealer.hand.extend(self.deck.deal(num=2))

    def play(self):
        while self.dealer.in_game:
            self.dealer.play(self.deck)
        for player in self.players:
            while player.in_game:
                player.play(self.deck)

    def pay(self):
        for player in self.players:
            if player.hand_value <= 21:
                if self.dealer.hand_value > 21:
                    player.capital += self.bets[player.name] * 2
                else:
                    if player.hand_value > self.dealer.hand_value:
                        player.capital += self.bets[player.name] * 2
                    elif player.hand_value == self.dealer.hand_value:
                        player.capital += self.bets[player.name]
        self.bets = {}
