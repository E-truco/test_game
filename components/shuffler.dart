import "dart:math";

import "deckgen.dart";




List<Card> shuffler(List<Card> deck, int amountOfDecks){

  List<Card> shuffledDeck = [];

  Random random = new Random(DateTime.now().microsecondsSinceEpoch);

  for(int i = 1; i <= amountOfDecks; i++){
    shuffledDeck += deck;
  }

  shuffledDeck.shuffle(random);

  return shuffledDeck;

}


void main(){

  var deck = deckgen(["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"], ["Clubs", "Diamonds", "Spades", "Hearts"]);

  var shuffledDeck = shuffler(deck, 1);

  shuffledDeck.forEach(print);

}