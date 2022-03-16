import 'package:flutter/material.dart';

import '../models/ttt_board.dart';

class Cell extends StatelessWidget {
  final CellType type;
  final VoidCallback moveCallback;

  const Cell({Key? key, required this.type, required this.moveCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cell = Container(
      padding: const EdgeInsets.all(8),
      color: Colors.black,
      child: FittedBox(
        child: Text(
          type.toCellString(),
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );

    if (type != CellType.empty) {
      return cell;
    }

    return GestureDetector(
      onTap: moveCallback,
      child: cell,
    );
  }
}
