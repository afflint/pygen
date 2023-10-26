from blackjack.utils import create_decks

deck = create_decks(
    symbols=[str(x) for x in range(2, 11)],
    num=2
)

for card in deck[:10]:
    print("{}{}".format(card.symbol, card.seed))