import 'package:flutter/material.dart';
import 'package:flutter_squares/models/solver.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BoardCell> board = List();
  List<CellController> controllers = List();

  double _getSmallestDimension(var height, var width) {
    double ret;

    ret = height > width ? width : height;
    return ret;
  }

  void _createBoard(double cellSize){
    for (int i=0; i<100; i++) {
      board.add(BoardCell(i, Colors.deepPurple, cellSize));
    }
  }

  Color _getColor(int offset) {
    List<Color> colors = [Colors.red, Colors.green,
      Colors.blue, Colors.purple, Colors.orange];
    return colors[offset];
  }

  void _createControllers(int count, Function buttonCb) {
    for (int i=0; i<count; i++){
      controllers.add(CellController(i, _getColor(i), buttonCb));
    }
  }

  void buttonCb(){
    print("buttonCb called");
  }

  @override
  Widget build(BuildContext context) {
    // Solver solv = Solver(3);
    // solv.generateBoard();
    // print("Print initial board:");
    // solv.printMatrix();
    // print("Call solver");
    // solv.debugTrivialBoard();

    const lines = 10;

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
                    var cellSize = _getSmallestDimension(
                            constraints.maxHeight, constraints.maxWidth) /
                        lines;
                    return _drawBoard(lines, cellSize);
                  },
                ))));
  }

  Widget _drawBoard(int lines, double cellSize) {
    _createBoard(cellSize);
    _createControllers(5, buttonCb());

    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GridView.count(
        crossAxisCount: lines,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: board
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: controllers
    )]);
  }
}

class BoardCell extends StatefulWidget {
  final int cellIndex;
  final Color cellColor;
  final double cellSize;

  @override
  _BoardCellState createState() => _BoardCellState();

  BoardCell(this.cellIndex, this.cellColor, this.cellSize);
}

class _BoardCellState extends State<BoardCell> {
  Widget _singleColoredCellBuilder() {

    return GestureDetector(
      child: Column(
        children: <Widget>[
          SizedBox(
              width: widget.cellSize,
              height: widget.cellSize,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: widget.cellColor,
                    border: Border.all(width: 0.5, color: Colors.white)),
              )),
        ],
      ),
      onTap: () async {
        print("Tapped cellIndex: ${widget.cellIndex}");
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return _singleColoredCellBuilder();
  }
}

class CellController extends StatefulWidget {
  final int controllerId;
  final Color controllerColor;
  final Function callback;

  CellController(this.controllerId, this.controllerColor, this.callback);

  @override
  _CellControllerState createState() => _CellControllerState();
}

class _CellControllerState extends State<CellController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
        height: 50,
        width: 50,
        color: widget.controllerColor,
      ),
      onTap: () async {
        print("Control ${widget.controllerId} pressed");
        widget.callback();
      },
    );
  }
}
