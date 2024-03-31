import "./components/deckgen.dart";
import "./components/shuffler.dart";
import "./components/croupier.dart";
import "./components/playerIO.dart";

import "dart:io";

class Game{

  List<List> teams = [];
  int currentRound = 0;

  Game(this.teams);

  @override
  String toString() => "Round: $currentRound | Teams: $teams";
}


// im not exatcly proud of this but it's the only way i managed to make it work
// why doesnt this work?????? Process.runSync('cls', [], runInShell: true)
void clearTerminal(){

  for(int i = 0; i < stdout.terminalLines; i++) {
    stdout.writeln();
  }
}


void main(){

  print('|=========================|');
  print('|         E-Truco         |');
  print('|-------------------------|');
  print('|        Test Game        |');
  print('|=========================|');
  print('');
  stdout.write('Press enter to continue: ');

  // detect key press
  stdin.readLineSync();

  clearTerminal();
  

  // create players
  // teams will be: p1 and p3 / p2 and p4
  print('|=========================|');
  print('|    Create 4 players.    |');
  print('|=========================|');
  print('');

  // player1 -> team A
  print('This player will be on team A [Player 1/4]');
  Player p1 = createPlayer();
  clearTerminal();

  // player2 -> team B
  print('This player will be on team B [Player 2/4]');
  Player p2 = createPlayer();
  clearTerminal();

  // player3 -> team A
  print('This player will be on team A [Player 3/4]');
  Player p3 = createPlayer();
  clearTerminal();

  // player4 -> team B
  print('This player will be on team B [Player 4/4]');
  Player p4 = createPlayer();
  clearTerminal();

  // confirm the players
  print('|=========================|');
  print('|     Confirm Players     |');
  print('|=========================|');

  print(p1);
  print(p2);
  print(p3);
  print(p4);
  print('');
  stdout.write('Press enter to continue: ');

  // detect key press
  stdin.readLineSync();
  


  // create deck
  List<Card> deck = deckgen(["4", "5", "6", "7", "10", "11", "12", "1", "2", "3"], ["Moles", "Espadas", "Copas", "Paus"]);

  // shuffle deck
  shuffler(deck, 1);

  // croupier
  croupier([p1, p2, p3, p4], 3, deck);

  // create game
  Game game = new Game([[p1, p3], [p2, p4]]);

}