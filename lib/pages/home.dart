import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game/game.dart';
import '../models/ttt_board.dart';

// TODO: Add a BlocListener to display a win/lose/tie dialog.
// TODO: Add a refresh button to the app bar.

// TODO: Show Russell published TTT Flutter code.

// TODO: Break out cells and boards into widgets.

class HomePage extends StatelessWidget {
  static const cellSpacing = 8.0;

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tic-Tac-Toe")),
      body: Center(
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
                      for (int i = 0; i < 9; i++) GestureDetector(
                        onTap: () => context.read<GameBloc>().move(i),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.black,
                          child: FittedBox(
                            child: Text(
                              state.board[i].toCellString(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
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
}
