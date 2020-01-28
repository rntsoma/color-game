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

    ret = height > width ? width : height;
    return ret;
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
                    var cellSize = _getSmallestDimension(
                            constraints.maxHeight, constraints.maxWidth) /
                        lines;
                    return _createBoard(lines, cellSize);
                  },
                ))));
  }

  Widget _createBoard(int lines, double cellSize) {
    return GridView.count(
      crossAxisCount: lines,
      physics: NeverScrollableScrollPhysics(),
      children: _createCells(lines * lines, cellSize),
    );
  }

  List<Widget> _createCells(int cellCount, double cellSize) {
    List<Widget> board = List.generate(
        cellCount,
        (int index) =>
            _singleColoredCellBuilder(cellSize, Colors.deepPurple, index));
    return board;
  }

  Widget _singleColoredCellBuilder(
      var cellSize, MaterialColor color, int index) {
    final cellIndex = index;

    return GestureDetector(
      child: Column(
        children: <Widget>[
          SizedBox(
              width: cellSize,
              height: cellSize,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: color,
                    border: Border.all(width: 0.5, color: Colors.white)),
              )),
        ],
      ),
      onTap: () => {print("Tapped cellIndex: $cellIndex")},
    );
  }
}
