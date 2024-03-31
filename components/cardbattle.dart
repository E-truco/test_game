
import "deckgen.dart";

int compare(List<Card> cards){

  int face1 = cards[0].trueValue;
  int face2 = cards[1].trueValue;

  int suit1 = cards[0].suitValue;
  int suit2 = cards[1].suitValue;

  if(face1 > face2){

    return 1;

  }else if(face2 > face1){

    return 2;

  // if both have the same face value
  }else{

    if(suit1 > suit2){

      return 1;

    }else if(suit2 > suit1){

      return 2;

    // if both are the same card
    }else{

      return 0;
      
    }
  }

}