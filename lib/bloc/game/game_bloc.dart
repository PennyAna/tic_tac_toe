import 'package:bloc/bloc.dart';

import '../../models/ttt_board.dart';
import 'game_state.dart';

class GameBloc extends Cubit<GameState> {
  GameBloc() : super(GameState(board: TTTBoard()));

  void restart() {
    emit(GameState(board: TTTBoard()));
  }

  void move(int index) {
    TTTBoard updatedBoard = state.board.move(index, state.currentPlayer);
    final winner = _checkForWin(updatedBoard);

    if (winner != state.board.winner) {
      updatedBoard = updatedBoard.copyWith(winner: winner);
    }

    emit(state.copyWith(
      board: updatedBoard,
      currentPlayer: state.currentPlayer == CellType.X ? CellType.O : CellType.X,
    ));
  }

  CellType _checkForWin(TTTBoard board) {
    // no win is possible before the 5th move
    if (board.moveCount >= 5) {
      for (final pattern in winPatterns) {
        if (board[pattern.cell1] != CellType.empty &&
            board[pattern.cell1] == board[pattern.cell2] &&
            board[pattern.cell1] == board[pattern.cell3]) {
          return board[pattern.cell1];
        }
      }
    }

    // no winner
    return CellType.empty;
  }
}
