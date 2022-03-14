import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../bloc/game/game.dart';
import '../models/ttt_board.dart';

class HomePage extends StatelessWidget {
  static const cellSpacing = 8.0;

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tic-Tac-Toe")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<GameBloc, GameState>(
                buildWhen: (previous, current) => previous.currentPlayer != current.currentPlayer,
                builder: (context, state) {
                  return Text(
                    "Player: ${state.currentPlayer.name}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline5,
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<GameBloc, GameState>(
                buildWhen: (previous, current) => previous.board != current.board,
                builder: (context, state) {
                  return LayoutGrid(
                    columnSizes: [1.fr, 1.fr, 1.fr],
                    rowSizes: const [auto, auto, auto],
                    rowGap: cellSpacing,
                    columnGap: cellSpacing,
                    children: [
                      for (int i = 0; i < 9; i++) GestureDetector(
                        onTap: () => context.read<GameBloc>().move(i),
                        child: Container(
                          color: Colors.grey,
                          child: state.board[i] == CellType.empty
                              ? null
                              : Center(
                                  child: Text(
                                    state.board[i].name,
                                    style: Theme.of(context).textTheme.headline1,
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
