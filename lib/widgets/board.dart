import 'package:flutter/material.dart';

import '../models/ttt_board.dart';
import 'cell.dart';

class Board extends StatelessWidget {
  static const cellSpacing = 8.0;

  final TTTBoard board;
  final ValueChanged<int> moveCallback;

  const Board({super.key, required this.board, required this.moveCallback});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      padding: const EdgeInsets.all(4),
      itemCount: 9,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Cell(
            type: board[i],
            moveCallback: () => moveCallback(i),
          ),
        );
      },
    );

    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: cellSpacing,
      mainAxisSpacing: cellSpacing,
      crossAxisCount: 3,
      children: [
        for (int i = 0; i < 9; i++)
          Cell(
            type: board[i],
            moveCallback: () => moveCallback(i),
          ),
      ],
    );
  }
}
