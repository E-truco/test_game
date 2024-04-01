import "croupier.dart";

import "dart:io";
import "dart:math";


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
  if(inputID != null && inputID != ''){

    id = int.parse(inputID);

  }else{

    Random random = new Random(DateTime.now().microsecondsSinceEpoch);

    id = random.nextInt(99);
  }

  // ask for player name
  stdout.write("Insert player name: ");
  String? inputName = stdin.readLineSync();

  // test if player name isn't null
  if(inputName != null && inputName != ''){

    name = inputName;

  }else{

    name = "Player$id";
  }

  print("-----------------------");
  print("Player created.");
  print("ID: $id");
  print("Name: $name");
  print("-----------------------");

  Player player = new Player(id, name, 0, []);
  return player;

}



void main(){

  Player player = createPlayer();

  print(player);
}

