import 'package:flutter/material.dart';

class GameBox extends StatelessWidget {
  Color col;
  String chi;
  GameBox({super.key,required this.col,required this.chi});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
          color:col,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(child: Text(chi)),
      ),
    );
  }
}
