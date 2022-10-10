import 'package:flutter/material.dart';

import '../utils/utils.dart' show ListX;

@immutable
class TTTBoard {
  late final List<CellType> grid;
  final CellType winner;

  TTTBoard({List<CellType>? grid, this.winner = CellType.empty}) {
    this.grid = grid ?? List.unmodifiable(List<CellType>.filled(9, CellType.empty));
  }

  TTTBoard copyWith({List<CellType>? grid, CellType? winner}) {
    return TTTBoard(
      grid: grid ?? this.grid,
      winner: winner ?? this.winner,
    );
  }

  TTTBoard move(int index, CellType cellType) {
    assert(index >= 0 && index < 9 && grid[index] == CellType.empty && cellType != CellType.empty);
    return copyWith(grid: List.unmodifiable(grid.toList()..replaceAt(index, cellType)));
  }

  @override
  String toString() {
    return """
    
${grid[0].toCellString()} | ${grid[1].toCellString()} | ${grid[2].toCellString()}
${grid[3].toCellString()} | ${grid[4].toCellString()} | ${grid[5].toCellString()}
${grid[6].toCellString()} | ${grid[7].toCellString()} | ${grid[8].toCellString()}

Winner: $winner
    """;
  }

  bool get isFull => !grid.any((cell) => cell == CellType.empty);
  bool get isNotFull => !isFull;

  bool get hasWinner => winner != CellType.empty;

  bool isCellEmpty(int index) => grid[index] == CellType.empty;

  int get moveCount => grid.where((cell) => cell != CellType.empty).length;

  CellType operator [](int index) => grid[index];
}

enum CellType {
  empty,
  X,
  O;

  String toCellString() => this == CellType.empty ? ' ' : name;
}

class WinPattern {
  final int cell1;
  final int cell2;
  final int cell3;

  const WinPattern(this.cell1, this.cell2, this.cell3);
}

const List<WinPattern> winPatterns = [
  WinPattern(0, 1, 2), // row 1
  WinPattern(3, 4, 5), // row 2
  WinPattern(6, 7, 8), // row 3
  WinPattern(0, 3, 6), // col 1
  WinPattern(1, 4, 7), // col 2
  WinPattern(2, 5, 8), // col 3
  WinPattern(0, 4, 8), // diag 1
  WinPattern(2, 4, 6), // diag 2
];