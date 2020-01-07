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
            body: LayoutBuilder(
              builder: (context, constraints) {
                var height = constraints.maxHeight;
                var width = constraints.maxWidth;
                print(constraints.maxWidth);
                print(constraints.maxHeight);
                return _createBoard(height, width);
              },
            )));
  }

  Widget _createBoard(var _boardHeigth, var _boardWidth) {
    List<Widget> _createRowList(var height, var width) {
      List<Widget> rowList = [];
      for(int i=0; i<9; i++){
        rowList.add(_coloredRowWidgetBuilder(height, width));
      }
      return rowList;
    }

    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        //for now, keep it as a single column with rows inside
        children: <Widget>[
          _coloredRowWidgetBuilder(_boardHeigth / 10, _boardWidth - 10),
      ),
    );
  }

  //nested columns, creating a non scrollable grid
  Widget _coloredRowWidgetBuilder(var _rowHeight, _rowWidth) {
    print("Row heigth: $_rowHeight");
    print("Row width: $_rowWidth");

    List<Widget> _createRowList(var height, var width) {
      List<Widget> rowList = [];
      for(int i=0; i<9; i++){
        rowList.add(_singleColoredCellBuilder(height, width));
      }
      return rowList;
    }

    return Container(
      child: Padding(
        //10 px from both margins
        padding: EdgeInsets.only(right: 0, left: 0),
        child: Row(
          children: _createRowList(_rowHeight, _rowWidth/10)
        ),
      ),
      height: _rowHeight,
      width: _rowWidth,
    );
  }

  Widget _singleColoredCellBuilder(var _cellHeight, var _cellWidth) {
    print("cell heigth: $_cellHeight");
    print("cell width: $_cellWidth");
    print("im here");

    //use the smallest size, for now
    var _size = _cellHeight > _cellWidth ? _cellWidth : _cellHeight;
    //cells with 5 px of distance from each other
    return Padding(
        padding: EdgeInsets.only(left: 1),
        child: Column(
          children: <Widget>[
            SizedBox(
                width: _size,
                height: _size,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                )),
          ],
        ));
  }
}
