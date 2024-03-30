
class Card {
  late String value;
  late String suit;
  late int trueValue;
  late int suitValue;

  Card(this.value, this.suit, this.trueValue, this.suitValue);

  @override
  String toString() => "[($trueValue)($suitValue) | $value of $suit]";
}

// values = array with the values of the cards as strings. example: ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"];
// VALUES SHOULD BE IN ORDER OF TRUE VALUE! in the example above, "2" has a true value of 1 and "A" has the true value of 13.
//
// suits = array with the suits of the cards as string. example: ["Clubs", "Diamonds", "Spades", "Hearts"];
// SUITS SHOULD BE IN ORDER OF SUIT VALUE! in the example above, "Clubs" has a true value of 1 and "Hearts" has a true value of 4.
List<Card> deckgen(List<String> values, List<String> suits) {
  List<Card> deck = [];

  for (var i = 0; i < values.length; i++) {
    for (var y = 0; y < suits.length; y++) {
      Card current = new Card(values[i], suits[y], i + 1, y + 1);
      deck.add(current);
    }
  }

  return deck;
}

void main() {

  var deck = deckgen(
      ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"],
      ["Clubs", "Diamonds", "Spades", "Hearts"]);

  deck.forEach(print);
}