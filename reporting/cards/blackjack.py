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
    def play(self, deck: BlackJackDeck):
        pass


class HumanPlayer(Player):
    def __init__(self, name: str, initial_capital: float = 100):
        super().__init__(initial_capital=initial_capital)
        self.name = name

    def bet(self):
        prompt = "{} actual value: {}\t".format(self.name, self.value_hand())
        user_input = input(prompt)
        try:
            b = float(user_input)
            self.capital -= b
            return b
        except ValueError:
            raise ValueError('Bet must be a valid number')

    def play(self, deck: BlackJackDeck):
        for i in range(1000):
            if self.status_stay:
                break
            if not self.status_in_game:
                break
            prompt = "{} Actual value: {}\t".format(self.name, self.value_hand())
            user_input = input(prompt)
            if user_input == 'hit':
                self.hit(deck)
            elif user_input == 'stay':
                self.stay()
            else:
                print("Choose hit or stay")


class Dealer(Player):
    def __init__(self, deck: BlackJackDeck, initial_capital: float = 100):
        super().__init__(initial_capital)
        self.deck = deck
        self.table = []
        self.bets = {}

    def add_player(self, player: Player):
        self.table.append(player)

    def serve(self):
        self.deck.shuffle()
        self.hand = self.deck.deal(num=2)
        for player in self.table:
            player.hand = self.deck.deal(num=2)

    def collect_bets(self):
        for player in self.table:
            bet = player.bet()
            self.bets[player.name] = bet

    def game(self):
        for player in self.table:
            player.play(self.deck)
        self.play(self.deck)

    def pay(self):
        d_value = self.value_hand()
        for player in self.table:
            if player.status_in_game:
                p_value = player.value_hand()
                if self.status_in_game:
                    if p_value > d_value:
                        player.capital += self.bets[player.name] * 2
                    elif p_value == d_value:
                        player.capital += self.bets[player.name]
                    else:
                        self.capital += self.bets[player.name]
                else:
                    player.capital += self.bets[player.name] * 2
            else:
                self.capital += self.bets[player.name]
        self.bets = {}

    def play(self, deck: BlackJackDeck):
        for i in range(1000):
            if self.status_stay:
                break
            if not self.status_in_game:
                break
            actual_value = self.value_hand()
            if actual_value < 17:
                self.hit(deck)
            elif 17 <= actual_value <= 21:
                self.stay()


