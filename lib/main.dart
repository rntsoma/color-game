import 'package:flutter/material.dart';
import 'package:flutter_squares/models/solver.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _boardSize;

  double _getSmallestDimension(var height, var width) {
    double ret;

    ret  = height > width ? width : height;
    return ret;
  }

  bool _useHeigthDimention (var height, var width) {
    bool ret;
    ret = height > width ? true : false;

    return ret;
  }

  double _getBoardSize(var constraints) {
    if (_useHeigthDimention(constraints.maxHeight, constraints.maxWidth)) {
      return constraints.maxHeight * 0.8;
    }
    return constraints.maxWidth * 0.8;
  }

  @override
  Widget build(BuildContext context) {
    // Solver solv = Solver(3);
    // solv.generateBoard();
    // print("Print initial board:");
    // solv.printMatrix();
    // print("Call solver");
    // solv.debugTrivialBoard();

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("ColorGame"),
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
            ),
            body: Padding(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    const lines = 10;
                    // var boardSize = _getBoardSize(constraints);
                    var cellSize = _getSmallestDimension(constraints.maxHeight, constraints.maxWidth)/lines;
                    // return _createBoard(boardSize, cellSize, lines);
                    _boardSize = _getBoardSize(constraints);
                    return _createBoard2(lines, cellSize.toInt());
                  },
                ))));
  }

  Widget _createBoard2(int lines, int cellSize) {
    List<List<Widget>> board = [];

    board = createCells(lines, cellSize);

    var row0 = board[0];
    var row1 = board[1];
    var row2 = board[2];
    var row3 = board[3];
    var row4 = board[4];
    var row5 = board[5];
    var row6 = board[6];
    var row7 = board[7];
    var row8 = board[8];
    var row9 = board[9];
    var row10 = board[10];
    var row11 = board[11];
    var row12 = board[12];
    var row13 = board[13];
    var row14 = board[14];
    var row15 = board[99];
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            for (var col in row0) Column(children: <Widget>[col],),
          ],),
        Row(
          children: <Widget>[
            for (var col in row10) Column(children: <Widget>[col],),
          ],),
        Row(
          children: <Widget>[
            for (var col in row11) Column(children: <Widget>[col],),
          ],),
        Row(
          children: <Widget>[
            for (var col in row12) Column(children: <Widget>[col],),
          ],),
        Row(
          children: <Widget>[
            for (var col in row13) Column(children: <Widget>[col],),
          ],),
        Row(
          children: <Widget>[
            for (var col in row14) Column(children: <Widget>[col],),
          ],),
      ],
    );

    // return Column(
    //   children: <Widget>[
    //     for (var row in board) Row(
    //       children: <Widget>[
    //         for (var col in row) Row(
    //           children: <Widget>[col],
    //           )
    //       ],
    //     )
    //   ],
    // );
  }

  List<List<Widget>> createCells(var lines, var cellSize) {
    List<List<Widget>> board = [];
    // var board = [10][10];

    print("Lines: $lines");
    print("CellSize: $cellSize");

    for(int i=0; i<lines; i++) {
      List<Widget> row  = [];

      for(int j=0; j<lines; j++) {
        row.add(
          GestureDetector(
            child: Column(
              children: <Widget>[
                SizedBox(
                    width: cellSize.floor().toDouble(),
                    height: cellSize.floor().toDouble(),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.deepPurple,
                      border: Border.all(width: 0.0, color: Colors.white)
                      ),
                    )),
              ],
              ),
              onTap: ()=>{print("Tapped")},
            )
        );
        board.add(row);
      }
    }

    return board;
  }

  Widget _createBoard(var boardSize, var cellSize, var rowCellCount) {
    List<Widget> _createRowList() {
      List<Widget> rowList = [];
      for(int i=0; i<rowCellCount; i++){
        rowList.add(_coloredRowWidgetBuilder(boardSize, cellSize, rowCellCount));
      }
      return rowList;
    }

    return Column(
        //for now, keep it as a single column with rows inside
        children: _createRowList()
        );
  }

  //nested columns, creating a non scrollable grid
  Widget _coloredRowWidgetBuilder(var rowWidth, var cellSize, var cellCount) {
    bool _flipColor = false;

    MaterialColor _changeColor(){
      _flipColor = !_flipColor;
      if (_flipColor) {
        return Colors.deepPurple;
     }
     return Colors.green;
    }

    List<Widget> _createRowList() {
      List<Widget> rowList = [];
      for (int i = 0; i < cellCount; i++) {
        rowList.add(_singleColoredCellBuilder(cellSize, _changeColor()));
      }
      return rowList;
    }

    return Container(
      child: Row(children: _createRowList()),
      height: cellSize,
      width: rowWidth,
    );
  }

  Widget _singleColoredCellBuilder(var cellSize, MaterialColor color) {
    return GestureDetector(
          child: Column(
        children: <Widget>[
          SizedBox(
              width: cellSize,
              height: cellSize,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color,
                border: Border.all(width: 1.0, color: Colors.white)
                ),
              )),
        ],
      ),
      onTap: ()=>{print("Tapped")},
    );
  }
}
