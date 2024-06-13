import 'package:flutter/material.dart';
int length=10;
int breadth=16;

enum Direction{
  down,left,right
}
enum Tetris{
  L,J,S,T,O,Z,I
}

Map<Tetris,Color> map={
  Tetris.J:Colors.red,
  Tetris.I:Colors.blue,
  Tetris.O:Colors.pink,
  Tetris.Z:Colors.green,
  Tetris.S:Colors.yellow,
  Tetris.T:Colors.deepOrange,
  Tetris.L:Colors.deepPurpleAccent,
};

class Piece{
  Tetris type;
  Piece({required this.type});
  List<int> pos=[];


  void gen_piece(){
    switch(type){
      case Tetris.L:
        pos=[-26,-16,-6,-5];
        break;

      case Tetris.J:
        pos=[-5,-15,-25,-6];
        break;
      case Tetris.S:
        pos=[-14,-15,-6,-5];
        break;
      case Tetris.T:
        pos=[-26,-16,-6,-15];
        break;
      case Tetris.O:
        pos=[-15,-16,-5,-6];
        break;
      case Tetris.Z:
        pos=[-17,-16,-6,-5];
        break;
      case Tetris.I:
        pos=[-4,-5,-6,-7];
        break;
    }
  }



  void MovePiece(Direction dir){
    switch(dir){

      case Direction.down:
        for(int i=0;i<pos.length;i++){
          pos[i]+=10;
          // print("${pos[i]} ");
        }
        break;


      case Direction.left:
        for(int i=0;i<pos.length;i++){
          pos[i]-=1;
        }
        break;


      case Direction.right:
        for(int i=0;i<pos.length;i++){
          pos[i]+=1;
        }
        break;
    }
  }
}