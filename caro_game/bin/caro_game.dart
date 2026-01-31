import 'dart:io';

/// Người chơi (OOP: Abstraction)
class Player {
  final String name;
  final String symbol;

  Player(this.name, this.symbol);
}

/// Bàn cờ (OOP: Encapsulation)
class Board {
  List<String> cells = List.filled(9, ' ');

  void display() {
    print('');
    print(' ${cells[0]} | ${cells[1]} | ${cells[2]} ');
    print('---+---+---');
    print(' ${cells[3]} | ${cells[4]} | ${cells[5]} ');
    print('---+---+---');
    print(' ${cells[6]} | ${cells[7]} | ${cells[8]} ');
    print('');
  }

  bool placeMove(int index, String symbol) {
    if (index < 0 || index > 8 || cells[index] != ' ') {
      return false;
    }
    cells[index] = symbol;
    return true;
  }

  bool checkWin(String symbol) {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (pattern.every((i) => cells[i] == symbol)) {
        return true;
      }
    }
    return false;
  }

  bool isFull() {
    return !cells.contains(' ');
  }

  void reset() {
    cells = List.filled(9, ' ');
  }
}

/// Game (OOP: Composition)
class Game {
  final Board board = Board();
  late Player player1;
  late Player player2;
  late Player currentPlayer;

  void start() {
    print('=== TIC TAC TOE (DART CONSOLE) ===');

    player1 = Player('Player 1', 'X');
    player2 = Player('Player 2', 'O');
    currentPlayer = player1;

    while (true) {
      board.display();
      print('${currentPlayer.name} (${currentPlayer.symbol}) chọn ô (1-9):');

      String? input = stdin.readLineSync();
      int? move = int.tryParse(input ?? '');

      if (move == null || !board.placeMove(move - 1, currentPlayer.symbol)) {
        print('Nước đi không hợp lệ. Thử lại!');
        continue;
      }

      if (board.checkWin(currentPlayer.symbol)) {
        board.display();
        print('${currentPlayer.name} THẮNG 🎉');
        break;
      }

      if (board.isFull()) {
        board.display();
        print('HÒA 🤝');
        break;
      }

      switchPlayer();
    }

    askReplay();
  }

  void switchPlayer() {
    currentPlayer =
        currentPlayer == player1 ? player2 : player1;
  }

  void askReplay() {
    print('Chơi lại không? (y/n)');
    String? answer = stdin.readLineSync();
    if (answer != null && answer.toLowerCase() == 'y') {
      board.reset();
      currentPlayer = player1;
      start();
    } else {
      print('Kết thúc game.');
    }
  }
}

/// MAIN
void main() {
  Game game = Game();
  game.start();
}
