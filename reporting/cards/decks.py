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
