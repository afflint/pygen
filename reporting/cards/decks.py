import numpy as np


def create_deck(range_limit: int = 11,
                symbols: list = None,
                seeds: tuple = None):
    if seeds is None:
        seeds = ('C', 'Q', 'F', 'P')
    if symbols is None:
        symbols = ['A', 'J', 'K', 'Q']
    surface_values = [str(x) for x in range(2, range_limit)]
    surface_values += symbols
    seeds = seeds
    deck = []
    for s_value in surface_values:
        chunk = [(s_value, seed) for seed in seeds]
        deck.extend(chunk)
    return deck


def blackjack_value(card: tuple) -> int:
    x = card[0]
    if x == 'A':
        return 11
    elif x in ['J', 'Q', 'K']:
        return 10
    else:
        return int(x)


def blackjack_hand_value(hand: list) -> int:
    return sum(blackjack_value(card) for card in hand)


def serve_hand_shuffle(deck: list) -> list:
    hand = []
    np.random.shuffle(deck)
    for i in range(2):
        try:
            card = deck.pop()
            hand.append(card)
        except:
            return None
    return hand


def serve_hand_index(deck: list) -> list:
    hand = []
    for x in range(2):
        try:
            i = np.random.randint(0, len(deck))
            card = deck.pop(i)
            hand.append(card)
        except:
            return None
    return hand


def serve_hand_choice(deck: list) -> list:
    hand = []
    card_indexes = np.random.choice(range(len(deck)), size=2, replace=False)
    for i in card_indexes:
        hand.append(deck[i])
    return hand


def serve_many_hands(deck: list, number_of_hands: int):
    hands = []
    for x in range(number_of_hands):
        hand = serve_hand_index(deck)
        if hand is None:
            deck = create_deck()
            hand = serve_hand_index(deck)
        hands.append(hand)
    return hands
