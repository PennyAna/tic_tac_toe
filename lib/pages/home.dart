import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/game/game.dart';
import '../models/ttt_board.dart';
import '../widgets/board.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<GameState>(gameCtrlProvider, (previous, current) {
      if (current.board.winner != CellType.empty) {
        _showEndDialog(context: context, ref: ref, winner: current.board.winner);
      }
      else if (current.board.isFull) {
        _showEndDialog(context: context, ref: ref);
      }
    });

    final state = ref.watch(gameCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Tic-Tac-Toe")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Player: ${state.currentPlayer.name}",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Board(
              board: state.board,
              moveCallback: ref.read(gameCtrlProvider.notifier).move,
            ),
          ),
        ],
      ),
    );
  }

  void _showEndDialog({
    required BuildContext context,
    required WidgetRef ref,
    CellType winner = CellType.empty,
  }) {
    final msg = winner != CellType.empty ? "Player ${winner.name} wins!" : "It's a tie!";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return SimpleDialog(
          title: Center(child: Text(msg)),
          children: [
            Center(
              child: SimpleDialogOption(
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'New Game',
                  onPressed: () {
                    Navigator.pop(context);
                    ref.invalidate(gameCtrlProvider);
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
