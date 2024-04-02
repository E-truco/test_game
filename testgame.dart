import "./components/deckgen.dart";
import "./components/shuffler.dart";
import "./components/croupier.dart";
import "./components/playerIO.dart";

import "dart:io";

import "components/cardpile.dart";

class Game{

  List<List> teams = [];
  int currentRound = 0;
  late String manilha;

  Game(this.teams, this.manilha);

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


void displayHand(List<Card> hand){

  print("Your hand:");

  for(int i = 0; i < hand.length; i++){
    Card currentCard = hand[i];
    print(" $i | $currentCard");
  }

  print("----------------------------------------------");
}


// this will return the face of the manilha for the "card"
// "card" should be the first card on the shuffled deck AFTER the croupier dealt 3 cards to each player
String manilhaFinder(Card card){
  
  // if the selected card is 3, AKA the strongest card
  if(card.value == '3'){

    return '4';

  }else{

    return (int.parse(card.value) + 1).toString();

  }
}

// this solution is not pretty but I only remembered about manilhas now so i have to improvise
// on the actual game this will be improved
void manilhaUpdater(Game game){

  // create a list with all players
  // again, there are better ways to do this but I didnt plan ahead so this will do.
  List<Player> players = [];
  players.add(game.teams[0][0]);
  players.add(game.teams[0][1]);
  players.add(game.teams[1][0]);
  players.add(game.teams[1][1]);

  // go through every player, check if the have a manilha and if they do, update the trueValue of that card
  // player loop
  for(int p = 0; p < players.length; p++){

    // current player's hand loop
    for(int c = 0; c < players[p].hand.length; c++){
      
      // if they have a manilha
      if(players[p].hand[c].value == game.manilha){

        players[p].hand[c].trueValue = 11;

      }
      // else do nothing

    }
  }

}

List<int> round(Game game){

  int pointsWorth = 1;

  // set all players' points to 0
  game.teams[0][0].points = 0;
  game.teams[0][1].points = 0;
  game.teams[1][0].points = 0;
  game.teams[1][1].points = 0;

  String manilha = game.manilha;

  print('|=========================|');
  print('|  New Round Starting...  |');
  print('|=========================|');
  print('| Manilha: $manilha');
  print('|-------------------------|');
  stdout.write('Press enter to continue: ');

  // detect key press
  stdin.readLineSync();

  clearTerminal();

  // check if any of the teams have reached 2 points by checking the amount of points of the first player of that team
  // when the while loop ends, a team will have won the round
  while(game.teams[0][0].points < 2 && game.teams[1][0].points < 2){

    List<Card> pile = [];
  
    // amount of players in the game = amount of teams * amount of players per team
    int amountOfPlayers = game.teams.length * game.teams[0].length;
    int currentTeam = 0;

    // this will run for amountOfPlayers times, each time it runs, one player makes a play
    for(int i = 0; i < amountOfPlayers; i++){

      clearTerminal();

      // order will be: first player from team A -> first player from team B -> second player from team A -> second player from team B
      Player currentPlayer = game.teams[currentTeam][(i/2).floor()];
      String currentPlayerName = currentPlayer.name;

      print("==========================================================");
      print('New Play Starting... (Best of 3 plays wins the round)');
      print("==========================================================");
      print("It's $currentPlayerName turn.");
      print("NO ONE ELSE SHOULD LOOK AT THE SCREEN NOW. ");
      print("==========================================================");
      stdout.write("Press enter when only $currentPlayerName is looking: ");

      // detect key press
      stdin.readLineSync();

      clearTerminal();

      print("==============================================");
      print("It's $currentPlayerName's turn.");
      print("==============================================");


      var tempManilha = game.manilha;
      print('Manilha: $tempManilha');
      print("----------------------------------------------");


      if(pile.length > 0){
        Card topOfPile = pile[0];
        print("Top of the pile: $topOfPile");
        print("----------------------------------------------");
      }

      displayHand(currentPlayer.hand);
      stdout.write("Choose a card to play by typing it's index: ");

      String? inputCard = stdin.readLineSync();
      int choosenCard;

      // test if choosen card isnt null and is less than the hand's length
      if(inputCard != null){

        choosenCard = int.parse(inputCard);

      }else{
        choosenCard = 0;
      }

      // assign the current team as the owner of the choosen card for win check later
      currentPlayer.hand[choosenCard].teamOwner = currentTeam;

      // add card to pile

      // if card is manilha, suit will be checked in case of a tie
      if(currentPlayer.hand[choosenCard].value == game.manilha){

        addToPile(pile, currentPlayer.hand[choosenCard], true);

      // if card is NOT manilha, suit will NOT be checked in case of a tie
      }else{

        addToPile(pile, currentPlayer.hand[choosenCard], false);

      }
      

      // remove the choosen card from the hand
      currentPlayer.hand.removeAt(choosenCard);

      // alternate between the teams
      if(currentTeam == 0){
        currentTeam = 1;
      }else{
        currentTeam = 0;
      }

    } // play ends (2 wins for round win)

    // assign points to the team that won the round

    // check if there's a tie (if the first and second card of the pile, counting top-down, have the same face value and are not manilhas)
    // there might be a better way to write this if but it's 1am and i'm not thinking straight
    // if there's a tie, give one point to both teams
    if(pile[0].trueValue == pile[1].trueValue && pile[0].trueValue != 11 && pile[1].trueValue != 11){

      game.teams[0][0].point += 1;
      game.teams[0][1].point += 1;
      game.teams[1][0].point += 1;
      game.teams[1][1].point += 1;

      clearTerminal();
      
      print('|===========================================|');
      print('|                Play Ended.                |');
      print('|-------------------------------------------|');
      print('|              THERE IS A TIE!              |');
      print('|===========================================|');


      // if there ISN'T a tie, give a point to the winner
    }else{

      int winningTeam = pile[0].teamOwner;

      // give one point to both players on that team
      game.teams[winningTeam][0].points += 1;
      game.teams[winningTeam][1].points += 1;

      clearTerminal();

      String winner1 = game.teams[winningTeam][0].name;
      String winner2 = game.teams[winningTeam][1].name;

      print('|===========================================|');
      print('|                Play Ended.                |');
      print('|-------------------------------------------|');
      print('| Winner team: $winner1 and $winner2');

    }


    String team1 = game.teams[0][0].name + ' and ' + game.teams[0][1].name;
    String team2 = game.teams[1][0].name + ' and ' + game.teams[1][1].name;
    var team1Pts = game.teams[0][0].points;
    var team2Pts = game.teams[1][0].points;
  
    print('|===========================================|');
    print('| First to 2 points wins. Points per team:');
    print('| Team $team1 -> $team1Pts');
    print('| Team $team2 -> $team2Pts');
    print('|-------------------------------------------|');

    stdout.write('Press enter to continue: ');

    // detect key press
    stdin.readLineSync();

    clearTerminal();

  } // round ends (3 wins for game win)

  print('round ended.');

  // string with the names of the players in each team
  String team1 = game.teams[0][0].name + ' and ' + game.teams[0][1].name;
  String team2 = game.teams[1][0].name + ' and ' + game.teams[1][1].name;

  // count the points of each team
  var team1Pts = game.teams[0][0].points;
  var team2Pts = game.teams[1][0].points;

  var winnerTeam;
  var winnerTeamIndex;

  // if first team won
  if(team1Pts > team2Pts){
    
    winnerTeam = team1;
    winnerTeamIndex = 0;

  // if second team won
  }else{

    winnerTeam = team2;
    winnerTeamIndex = 1;
  }


    print('|===========================================|');
    print('|                Round Ended                |');
    print('|-------------------------------------------|');
    print('| Winner team: $winnerTeam');
    print('|-------------------------------------------|');
    print('| First to 2 points won. Points per team:');
    print('| Team $team1 -> $team1Pts');
    print('| Team $team2 -> $team2Pts');
    print('|===========================================|');


  
  // the return of round() is a list of two ints
  // first int is the index of the winning team
  // second int is the amount of points
  return [winnerTeamIndex ,pointsWorth];

}


void gameHandler(){

  // both teams start with zero points
  // game ends when one reaches 12
  List<int> pointsPerTeam = [0, 0];

  // --------------
  // setup begins
  // --------------

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

  // -------------
  // setup ends
  // -------------


  int pointsTeam0 = 0;
  int pointsTeam01 = 0;

  // each loop is a round
  // while none of the teams have reached 12 points, start a new round
  while(pointsTeam0 < 12 && pointsTeam01 < 12){


    // create deck
    List<Card> deck = deckgen(["4", "5", "6", "7", "10", "11", "12", "1", "2", "3"], ["Moles", "Espadas", "Copas", "Paus"]);

    // shuffle deck
    deck = shuffler(deck, 1);

    // make sure all players have empty hands
    p1.hand = [];
    p2.hand = [];
    p3.hand = [];
    p4.hand = [];

    // croupier
    croupier([p1, p2, p3, p4], 3, deck);

    // get manilha
    String manilha = manilhaFinder(deck[0]);
    deck.removeAt(0);


   // create game
    Game game = new Game([[p1, p3], [p2, p4]], manilha);

    // check if any players have a manilha and if they do, update it's trueValue to 11
    // before opening an issue, read the comments on the manilhaUpdater() function, thank you
    manilhaUpdater(game);


    clearTerminal();

    // instead of starting a round, start a game via gameHandler()
    // game will have part of the logic that is currently on this main function, as each game will have a different deck
    // game will start a round and keep track of rounds won
    // round will keep track of truco calls
    // round should return the winning team and also the amount of points that team got

    // start a round
    // return value is [indexOfWinnerTeam, amountOfPoints]
    List<int> latestRound = round(game);

    // update the amount of points per team
    pointsPerTeam[latestRound[0]] = latestRound[1];

    // this is the end of the rounds loop, if none of the teams have 12 points, it will run again
    // if one of the teams got to 12 points, it will stop
  }

  var gameWinnerTeam;

  String team1Names = p1.name + ' and ' + p3.name;
  String team2Names = p2.name + ' and ' + p4.name;

  int gamePointsTeam1 = pointsPerTeam[0];
  int gamePointsTeam2 = pointsPerTeam[1];

  // if first team won the game
  if(pointsPerTeam[0] > pointsPerTeam[1]){

    gameWinnerTeam = team1Names;

  // if second team won the game
  }else{

    gameWinnerTeam = team2Names;
  }

  print('|===========================================|');
  print('|                Game Ended.                |');
  print('|-------------------------------------------|');
  print('| Winner team: $gameWinnerTeam');
  print('|-------------------------------------------|');
  print('| First to 12 points won. Points per team:');
  print('| Team $team1Names -> $gamePointsTeam1');
  print('| Team $team2Names -> $gamePointsTeam2');
  print('|===========================================|');

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
  
  gameHandler();

}