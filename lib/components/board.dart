
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/components/box_page.dart';
import 'package:tetris/components/pieces.dart';


List<List<Tetris?>> board= List.generate(breadth,
        (index) => List.generate(
          length, (j)=>null
        )
);


class Board extends StatefulWidget {
  Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Piece current=Piece(type: Tetris.S);


  @override
  void initState() {
    // TODO: implement initState
    gamestart();
  }

  void gamestart(){
    current.gen_piece();
    Duration frame=const Duration(milliseconds: 800);
    gameloop(frame);
  }

  void gameloop(Duration frame){
    Timer.periodic(
      frame,
      (timer) {
        setState(() {
          landing();

          current.MovePiece(Direction.down);
        });
      },
    );
  }


  bool collision(Direction dir){
    for(int i=0;i<current.pos.length;i++){
      int r=current.pos[i] ~/ 10;
      int c=current.pos[i] % 10;

      if(dir== Direction.left){
        c-=1;
      }
      else if(dir==Direction.right){
        c+=1;
      }
      else if(dir==Direction.down){
        r+=1;
      }
      if(r>=breadth || c<0 || c>=length || board[r][c]!=null)return true;
    }
    return false;
  }

  void landing(){
    if(collision(Direction.down)){
      for(int i=0;i<current.pos.length;i++){
        int r=current.pos[i] ~/ 10;
        int c=current.pos[i] % 10;

        if(r>=0 && c>=0){
          board[r][c]=current.type;
        }
      }
      createnewPiece();
    }
  }

  void createnewPiece(){
    Random rand=Random();

    Tetris rand_type= Tetris.values[rand.nextInt(Tetris.values.length)];
    current=Piece(type: rand_type);
    current.gen_piece();
  }

  void moveleft(){
    if(!collision(Direction.left)){
      setState(() {
        current.MovePiece(Direction.left);
      });
    }
  }

  void rotate(){
    if(!collision(Direction.right)){
      setState(() {
        current.MovePiece(Direction.right);
      });
    }
  }

  void moveright(){}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            // flex :5,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount:length*breadth,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: length,
            ), itemBuilder: (context, index) {
                int r=index ~/ 10;
                int c=index % 10;
                if(current.pos.contains(index)){
                  return GameBox(col: map[current.type]??Colors.white, chi:"");
                }
                else if(board[r][c]!=null){
                  return GameBox(col: map[board[r][c]]??Colors.white, chi: "");
                }
                else{
                  return GameBox(col: Colors.white24, chi: index.toString());
                }
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: moveleft, icon: Icon(Icons.chevron_left)),
                IconButton(onPressed: moveright, icon: Icon(Icons.rotate_left_sharp)),
                IconButton(onPressed: rotate, icon: Icon(Icons.chevron_right)),

              ],
            ),
          )
        ],
      ),
    );
  }
}
