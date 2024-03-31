import "croupier.dart";

import "dart:io";


Player createPlayer(){

  int id;

  print("-----------------------");
  print("Create Player");
    print("-----------------------");
  stdout.write("Insert player ID: ");
  String? input = stdin.readLineSync();

  if(input != null){

    id = int.parse(input);

  }else{

    throw Exception("Please insert a valid integer ID.");
  }

  print("-----------------------");
  print("Player created. ID: $id");
  print("-----------------------");

  Player player = new Player(id, 0, []);
  return player;

}



void main(){

  Player player = createPlayer();

  print(player);
}

