import 'package:flutter/material.dart';

class BoardCell extends StatefulWidget {
  final Color cellColor;
  final double cellSize;

  @override
  _BoardCellState createState() => _BoardCellState();

  BoardCell(this.cellColor, this.cellSize);
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
    );
  }
  @override
  Widget build(BuildContext context) {
    return _singleColoredCellBuilder();
  }
}