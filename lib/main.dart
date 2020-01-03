import 'package:flutter/material.dart';
import 'package:flutter_squares/models/solver.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    Solver solv = Solver(3);
    solv.generateBoard();
    print("Print initial board:");
    solv.printMatrix();
    print("Call solver");
    solv.debugTrivialBoard();

    return Container(
      color: Colors.deepPurple,
    );
  }
}