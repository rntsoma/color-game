import 'package:flutter/material.dart';
import 'package:flutter_squares/models/solver.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BoardCell> board = List();

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

    for (int i=0; i<100; i++) {
      board.add(BoardCell(i));
    }

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

    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GridView.count(
        crossAxisCount: lines,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: _createCells(lines * lines, cellSize),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _createControllers(5),)
    ]);
  }

  List<Widget> _createCells(int cellCount, double cellSize) {
    List<Widget>cells = List.generate(
        cellCount,
        (int index) =>
            board[index].singleColoredCellBuilder(cellSize, Colors.deepPurple, index));
    return cells;
  }

  List<Widget> _createControllers(int numColors) {
    Color getColor(int offset) {
      List<Color> colors = [Colors.red, Colors.green,
        Colors.blue, Colors.purple, Colors.orange];
      return colors[offset];
    }

    List<Widget> controls = List.generate(
        numColors,
        (int controlID) => GestureDetector(
                  child: Container(
                height: 50,
                width: 50,
                color: getColor(controlID),
              ),
              onTap: () async {
                print("Control $controlID pressed");
                print(board[0]);
              },
        ));

    return controls;
  }
}

class BoardCell {
  final int cellIndex;

  BoardCell(this.cellIndex);

  Widget singleColoredCellBuilder(
      var cellSize, MaterialColor color, int index) {

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
      onTap: () async {
        print("Tapped cellIndex: $cellIndex");
      },
    );
  }
}
