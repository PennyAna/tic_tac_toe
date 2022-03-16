import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game/game.dart';
import '../models/ttt_board.dart';
import '../widgets/cell.dart';

// TODO: Break out boards into widgets.

class HomePage extends StatelessWidget {
  static const cellSpacing = 8.0;

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tic-Tac-Toe")),
      body: BlocListener<GameBloc, GameState>(
        listener: (context, state) {
          if (state.board.winner != CellType.empty) {
            _showEndDialog(context, state.board.winner);
          }
          else if (state.board.isFull) {
            _showEndDialog(context);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<GameBloc, GameState>(
                  buildWhen: (previous, current) => previous.currentPlayer != current.currentPlayer,
                  builder: (context, state) {
                    return Text(
                      "Player: ${state.currentPlayer.name}",
                      style: Theme.of(context).textTheme.headline5,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: BlocBuilder<GameBloc, GameState>(
                buildWhen: (previous, current) => previous.board != current.board,
                builder: (context, state) {
                  return GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(16),
                    crossAxisSpacing: cellSpacing,
                    mainAxisSpacing: cellSpacing,
                    crossAxisCount: 3,
                    children: [
                      for (int i = 0; i < 9; i++) Cell(
                        type: state.board[i],
                        moveCallback: () => context.read<GameBloc>().move(i),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEndDialog(BuildContext context, [CellType winner = CellType.empty]) {
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
                    context.read<GameBloc>().restart();
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
