import 'dart:io';

class TicTacToe {
  List<String> board = List.filled(9, ' ');
  String currentPlayer = 'X';

  void start() {
    while (true) {
      printBoard();
      print('Player $currentPlayer, enter position (1-9): ');
      int? move = int.tryParse(stdin.readLineSync() ?? '');

      if (move == null || move < 1 || move > 9 || board[move - 1] != ' ') {
        print('Invalid move. Try again.');
        continue;
      }

      board[move - 1] = currentPlayer;

      if (checkWin()) {
        printBoard();
        print('🎉 Player $currentPlayer wins!');
        break;
      }

      if (!board.contains(' ')) {
        printBoard();
        print('🤝 Draw!');
        break;
      }

      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }
  }

  void printBoard() {
    print('');
    for (int i = 0; i < 9; i += 3) {
      print(' ${board[i]} | ${board[i + 1]} | ${board[i + 2]} ');
      if (i < 6) print('---+---+---');
    }
    print('');
  }

  bool checkWin() {
    const wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var w in wins) {
      if (board[w[0]] != ' ' &&
          board[w[0]] == board[w[1]] &&
          board[w[1]] == board[w[2]]) {
        return true;
      }
    }
    return false;
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.start();
}
