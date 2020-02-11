import 'package:flutter/material.dart';

class CellController extends StatelessWidget {
  final int controllerId;
  final Color controllerColor;
  final Function cb;

  CellController(this.controllerId, this.controllerColor, this.cb);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
        height: 50,
        width: 50,
        color: controllerColor,
      ),
      onTap: () async {
        print("Control $controllerId pressed");
        cb(controllerId);
      },
    );
  }
}