import "cardbattle.dart";
import "deckgen.dart";


List<Card> addToPile(List<Card> pile, Card cardToBeAdded){

  // if pile is empty
  if(pile.length == 0){

    pile.add(cardToBeAdded);

    return pile;
  }

  // get the current strongest card
  Card topCard = pile[0];

  // strongest = 1 -> card to be added is the strongest
  // strongest = 1 -> card to be added is NOT the strongest
  int strongest = cardbattle([cardToBeAdded, topCard]);

  // if the card to be added is the strongest
  if(strongest == 1){

    pile.insert(0, cardToBeAdded);

  // if the card to be added is NOT the strongest
  }else{

    pile.add(cardToBeAdded);
  }

  return pile;

}