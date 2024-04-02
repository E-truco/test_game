import "cardbattle.dart";
import "deckgen.dart";


List<Card> addToPile(List<Card> pile, Card cardToBeAdded, bool checkSuits){

  // if pile is empty
  if(pile.length == 0){

    pile.add(cardToBeAdded);

    return pile;
  }

  // get the current strongest card
  Card topCard = pile[0];

  // strongest = 1 -> card to be added is the strongest
  // strongest = 2 -> card to be added is NOT the strongest
  // strongest = 0 -> card to be added has the same face value as the top card (tie) this also means they are NOT both manilhas
  int strongest = cardbattle([cardToBeAdded, topCard], checkSuits);

  // if the card to be added is the strongest OR it's a tie, add it to the top of the pile
  if(strongest == 1 || strongest == 0){

    pile.insert(0, cardToBeAdded);

  // if the card to be added is NOT the strongest, add it to the bottom of the pile
  }else{

    pile.add(cardToBeAdded);


  }

  return pile;

}