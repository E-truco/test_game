import "./components/deckgen.dart";
import "./components/shuffler.dart";
import "./components/croupier.dart";
import "./components/playerIO.dart";

class Game{

  List<List> teams = [];
  int currentRound = 0;

  Game(this.teams);

  @override
  String toString() => "Round: $currentRound | Teams: $teams";
}


void main(){

  print('=============');
  print('|  E-Truco  |');
  print('-------------');
  print('| test game |');
  print('=============');


  // create players
  // teams will be: p1 and p3 / p2 and p4
  Player p1 = createPlayer();
  Player p2 = createPlayer();
  Player p3 = createPlayer();
  Player p4 = createPlayer();


  // create deck
  List<Card> deck = deckgen(["4", "5", "6", "7", "10", "11", "12", "1", "2", "3"], ["Moles", "Espadas", "Copas", "Paus"]);

  // shuffle deck
  shuffler(deck, 1);

  // croupier
  croupier([p1, p2, p3, p4], 3, deck);

  // create game
  Game game = new Game([[p1, p3], [p2, p4]]);

}