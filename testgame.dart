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


void round(Game game){
  
  // amount of players in the game = amount of teams * amount of players per team
  int amountOfPlayers = game.teams.length * game.teams[0].length;
  int currentTeam = 0;

  // this will run for amountOfPlayers times, each time it runs, one player makes a play
  for(int i = 0; i < amountOfPlayers; i++){

    clearTerminal();

    // order will be: first player from team A -> first player from team B -> second player from team A -> second player from team B
    Player currentPlayer = game.teams[currentTeam][(i/2).floor()];
    String currentPlayerName = currentPlayer.name;

    print("==============================================");
    print("It's $currentPlayerName turn.");
    print("NO ONE ELSE SHOULD LOOK AT THE SCREEN NOW. ");
    print("==============================================");
    stdout.write("Press enter when only $currentPlayerName is looking: ");

    // detect key press
    stdin.readLineSync();

    clearTerminal();

    print("==============================================");
    print("It's $currentPlayerName turn.");
    print("----------------------------------------------");
    print("Your cards are: ");
    print(currentPlayer.hand);
    print("----------------------------------------------");
    stdout.write("Choose a card to play by typing it's index (starting on 0): ");

    String? inputCard = stdin.readLineSync();
    int choosenCard;

    // test if choosen card isnt null and is less than the hand's length
    if(inputCard != null && int.parse(inputCard) < currentPlayer.hand.length){

      choosenCard = int.parse(inputCard);

    }else{
      choosenCard = 0;
    }

    // remove the choosen card from the hand
    currentPlayer.hand.removeAt(choosenCard);

    // add card to the pile
    // i will also need to create a pile
    // and also code a system to check if card is stronger than other
    // and also make a system to organize the pile
    // also need to find manilha







    // alternate between the teams
    if(currentTeam == 0){
      currentTeam = 1;
    }else{
      currentTeam = 0;
    }
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