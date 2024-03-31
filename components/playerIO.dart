import "croupier.dart";

import "dart:io";


Player createPlayer(){

  int id;
  String name;

  // ask for player ID
  print("-----------------------");
  print("Create Player");
  print("-----------------------");
  stdout.write("Insert player ID: ");
  String? inputID = stdin.readLineSync();

  // test if player ID isn't null
  if(inputID != null){

    id = int.parse(inputID);

  }else{

    throw Exception("Please insert a valid integer ID.");
  }

  // ask for player name
  stdout.write("Insert player name: ");
  String? inputName = stdin.readLineSync();

  // test if player name isn't null
  if(inputName != null){

    name = inputName;

  }else{

    name = "name";
  }

  print("-----------------------");
  print("Player created.");
  print("ID: $id");
  print("Name: $name");
  print("-----------------------");

  Player player = new Player(id, 'player', 0, []);
  return player;

}



void main(){

  Player player = createPlayer();

  print(player);
}

