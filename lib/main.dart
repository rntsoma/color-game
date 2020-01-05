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

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("ColorGame"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column( //for now, keep it as a single column with rows inside
        // children: <Widget>[_coloredRowWidgetBuilder()],
        children: <Widget>[Container(color: Colors.greenAccent,)],
      ),
    ));
  }

  //nested columns, creating a non scrollable grid
  Widget _coloredRowWidgetBuilder() {
    return Row(
      children: <Widget>[
        _singleColoredCellBuilder(),
        _singleColoredCellBuilder(),
      ],
    );
  }

  Widget _singleColoredCellBuilder() {
    print("im here");
    return Column(
      children: <Widget>[Container(color: Colors.deepPurple,)],
    );
  }
}
