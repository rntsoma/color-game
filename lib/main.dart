import 'package:flutter/material.dart';
import 'package:flutter_squares/models/solver.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                    const lines = 20;
                    var boardSize = _getBoardSize(constraints);
                    var cellSize = _getSmallestDimension(constraints.maxHeight, constraints.maxWidth)/lines;
                    return _createBoard(boardSize, cellSize, lines);
                  },
                ))));
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
    return Column(
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
    );
  }
}
