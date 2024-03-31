import "./components/deckgen.dart";
import "./components/shuffler.dart";
import "./components/croupier.dart";

class Game{

  List<List> teams = [];
  int currentRound = 0;

  Game(this.teams);

  @override
  String toString() => "Round: $currentRound | Teams: $teams";
}


Player createPlayer(int id){
  return new Player(id, 0, []);
}


void main(){

  print('=============');
  print('|  E-Truco  |');
  print('-------------');
  print('| test game |');
  print('=============');
  print('Game setup must be hard coded.');


  // create players
  // teams will be: p1 and p3 / p2 and p4
  Player p1 = new Player(1, 0, []);
  Player p2 = new Player(2, 0, []);
  Player p3 = new Player(3, 0, []);
  Player p4 = new Player(4, 0, []);


  // create deck
  List<Card> deck = deckgen(["4", "5", "6", "7", "10", "11", "12", "1", "2", "3"], ["Moles", "Espadas", "Copas", "Paus"]);

  // shuffle deck
  shuffler(deck, 1);

  // croupier
  croupier([p1, p2, p3, p4], 3, deck);

  // create game
  Game game = new Game([[p1, p3], [p2, p4]]);

}