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
                    var height = constraints.maxHeight;
                    var width = constraints.maxWidth;
                    var smallestDimension = height > width ? width : height;
                    var _cellSize = smallestDimension/lines;
                    print(constraints.maxWidth);
                    print(constraints.maxHeight);
                    return _createBoard(smallestDimension, _cellSize, lines);
                  },
                ))));
  }

  Widget _createBoard(var _boardSize, var _cellSize, var _rowCellCount) {
    List<Widget> _createRowList() {
      List<Widget> rowList = [];
      for(int i=0; i<_rowCellCount; i++){
        rowList.add(_coloredRowWidgetBuilder(_boardSize, _cellSize, _rowCellCount));
      }
      return rowList;
    }

    return Column(
        //for now, keep it as a single column with rows inside
        children: _createRowList()
        );
  }

  //nested columns, creating a non scrollable grid
  Widget _coloredRowWidgetBuilder(var _rowWidth, var _cellSize, var _cellCount) {
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
      for (int i = 0; i < _cellCount; i++) {
        rowList.add(_singleColoredCellBuilder(_cellSize, _changeColor()));
      }
      return rowList;
    }

    return Container(
      child: Row(children: _createRowList()),
      height: _cellSize,
      width: _rowWidth,
    );
  }

  Widget _singleColoredCellBuilder(var _cellSize, MaterialColor color) {
    return Column(
      children: <Widget>[
        SizedBox(
            width: _cellSize,
            height: _cellSize,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color,
              border: Border.all(width: 1.0, color: Colors.white)
              ),
            )),
      ],
    );
  }
}
