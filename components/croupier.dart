
import "deckgen.dart";
import "shuffler.dart";


class Player{
  late int id;
  late String name;
  late int points;
  late List<Card> hand;

  Player(this.id, this.name, this.points, this.hand);

  @override
  String toString() => "ID: $id | Name: $name | Points: $points | Hand: $hand";
}


// players is a list of Player objects, should be in order of first to last to get their cards
// cardsPerPlayer is the amount of cards each player should receive
// deck is the deck the cards will be drawn from (following index order and removing the cards from the list as they are given)
// cards will be given one by one, example: Player1 gets a card, then Player2 gets a card... until all players have cardsPerPlayer amount of cards
List croupier(List<Player> players, int cardsPerPlayer, List<Card> deck){

  // totalCards is the amount of players times the amount of cards per player, it's the amount of cards to be distributed
  int totalCards = players.length * cardsPerPlayer;
  // currentPlayer is a counter for which player should get their card next
  int currentPlayer = 0;

  // test for future error
  if(totalCards > deck.length){
    var decksNeeded = (deck.length / (totalCards - deck.length)).ceil();
    throw FormatException("There aren't enough cards on the deck. You need $decksNeeded more decks.");
  }

  for(int i = 0; i < totalCards; i++){

    // give currentPlayer the first card of the deck
    players[currentPlayer].hand.add(deck[0]);
    // remove the first card of the deck
    deck.removeAt(0);

    // if the currentPlayer is the last player on the list
    if(currentPlayer == players.length - 1){

      // go back to the first player on the list
      currentPlayer = 0;
    
    // if the currentPlayer is NOT the last player on the list
    }else{

      // go to the next player on the list
      currentPlayer = currentPlayer + 1;

    }
  }


  // return the updated list os players and the updated deck
  return [players, deck];
}





void main(){

  var deck = deckgen(["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"], ["Clubs", "Diamonds", "Spades", "Hearts"]);

  var shuffledDeck = shuffler(deck, 1);

  print("Shuffled Deck:");
  shuffledDeck.forEach(print);

  Player p1 = new Player(1, 'player1', 0, []);
  Player p2 = new Player(2, 'player2', 0, []);

  var croupierOutput = croupier([p1, p2], 3, shuffledDeck);

  var newPlayers = croupierOutput[0];
  var newDeck = croupierOutput[1];

  print("New players:");
  newPlayers.forEach(print);
  print("New deck:");
  newDeck.forEach(print);

}