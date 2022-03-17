import 'package:flutter/material.dart';

import '../models/ttt_board.dart';
import 'cell.dart';

class Board extends StatelessWidget {
  static const cellSpacing = 8.0;

  final TTTBoard board;
  final ValueChanged<int> moveCallback;

  const Board({Key? key, required this.board, required this.moveCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: cellSpacing,
      mainAxisSpacing: cellSpacing,
      crossAxisCount: 3,
      children: [
        for (int i = 0; i < 9; i++) Cell(
          type: board[i],
          moveCallback: () => moveCallback(i),
        ),
      ],
    );
  }
}
