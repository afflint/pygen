class Player:

    def __init__(self):
        self.hand = []
        self.in_game = True

    @property
    def hand_value(self):
        return sum(x.value for x in self.hand)

    def get_status(self):
        return "Hand Value: {}, In game {}".format(
            self.hand_value, self.in_game)


class Dealer(Player):

    def start(self, deck):
        self.hand = deck.draw(num=2)

    def hit(self, deck):
        self.hand.extend(deck.draw(num=1))

    def act(self, deck):
        if self.hand_value < 17:
            self.hit(deck)
        elif 17 <= self.hand_value <= 21:
            pass
        else:
            self.in_game = False
        if self.hand_value < 17:
            return True
        else:
            if self.hand_value > 21:
                self.in_game = False
            return False


