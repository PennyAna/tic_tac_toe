import '../../models/ttt_board.dart';

class GameState {
  final TTTBoard board;
  final CellType currentPlayer;

  const GameState({required this.board, this.currentPlayer = CellType.X});

  GameState copyWith({TTTBoard? board, CellType? currentPlayer}) {
    return GameState(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
    );
  }
}