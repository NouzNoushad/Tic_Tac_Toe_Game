import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../core/constant.dart';
import '../screen/dialog_box.dart';

part 'tic_tac_toe_state.dart';

class TicTacToeCubit extends Cubit<TicTacToeState> {
  TicTacToeCubit() : super(TicTacToeInitial());

  int playerOScore = 0;
  int playerXScore = 0;
  bool playerOTurn = true;

  late List<String> playerOXMoves;
  int addUpBoxes = 0;
  String playerOXIndex = '';

  initPlayers() {
    playerOXMoves = generateList;
  }

  List<String> get generateList => List.generate(9, (index) => '');

  clearBoard() {
    playerOXMoves = generateList;
    addUpBoxes = 0;
  }

  onPressedPlayAgain(context) {
    clearBoard();
    Navigator.pop(context);
    emit(RefreshBoard());
  }

  resetGame() {
    clearBoard();
    playerOScore = 0;
    playerXScore = 0;
    emit(RefreshBoard());
  }

  setWinnerScore(String winner) {
    if (winner == 'O') {
      playerOScore += 1;
    }
    if (winner == 'X') {
      playerXScore += 1;
    }
  }

  GameStatus checkWinner(context, onPressed) {
    // Check Row
    // 1st row
    playerOXIndex = playerOXMoves[0];
    if (playerOXIndex != '' &&
        playerOXIndex == playerOXMoves[1] &&
        playerOXIndex == playerOXMoves[2]) {
      showWinnerDialog(playerOXIndex, context, GameStatus.win, onPressed);
      setWinnerScore(playerOXIndex);
      return GameStatus.win;
    }
    // 2st row
    playerOXIndex = playerOXMoves[3];
    if (playerOXIndex != '' &&
        playerOXIndex == playerOXMoves[4] &&
        playerOXIndex == playerOXMoves[5]) {
      showWinnerDialog(playerOXIndex, context, GameStatus.win, onPressed);
      setWinnerScore(playerOXIndex);
      return GameStatus.win;
    }
    // 3st row
    playerOXIndex = playerOXMoves[6];
    if (playerOXIndex != '' &&
        playerOXIndex == playerOXMoves[7] &&
        playerOXIndex == playerOXMoves[8]) {
      showWinnerDialog(playerOXIndex, context, GameStatus.win, onPressed);
      setWinnerScore(playerOXIndex);
      return GameStatus.win;
    }
    // Check Column
    // 1st column
    playerOXIndex = playerOXMoves[0];
    if (playerOXIndex != '' &&
        playerOXIndex == playerOXMoves[3] &&
        playerOXIndex == playerOXMoves[6]) {
      showWinnerDialog(playerOXIndex, context, GameStatus.win, onPressed);
      setWinnerScore(playerOXIndex);
      return GameStatus.win;
    }
    // 2st column
    playerOXIndex = playerOXMoves[1];
    if (playerOXIndex != '' &&
        playerOXIndex == playerOXMoves[4] &&
        playerOXIndex == playerOXMoves[7]) {
      showWinnerDialog(playerOXIndex, context, GameStatus.win, onPressed);
      setWinnerScore(playerOXIndex);
      return GameStatus.win;
    }
    // 3st column
    playerOXIndex = playerOXMoves[2];
    if (playerOXIndex != '' &&
        playerOXIndex == playerOXMoves[5] &&
        playerOXIndex == playerOXMoves[8]) {
      showWinnerDialog(playerOXIndex, context, GameStatus.win, onPressed);
      setWinnerScore(playerOXIndex);
      return GameStatus.win;
    }
    // Check Diagonal
    // 1st diagonal
    playerOXIndex = playerOXMoves[0];
    if (playerOXIndex != '' &&
        playerOXIndex == playerOXMoves[4] &&
        playerOXIndex == playerOXMoves[8]) {
      showWinnerDialog(playerOXIndex, context, GameStatus.win, onPressed);
      setWinnerScore(playerOXIndex);
      return GameStatus.win;
    }
    // 2st diagonal
    playerOXIndex = playerOXMoves[2];
    if (playerOXIndex != '' &&
        playerOXIndex == playerOXMoves[4] &&
        playerOXIndex == playerOXMoves[6]) {
      showWinnerDialog(playerOXIndex, context, GameStatus.win, onPressed);
      setWinnerScore(playerOXIndex);
      return GameStatus.win;
    }
    return GameStatus.draw;
  }

  checkDraw(context, onPressed) {
    // Draw
    GameStatus gameStatus = checkWinner(context, onPressed);
    if (addUpBoxes == 9 && gameStatus != GameStatus.win) {
      showWinnerDialog('', context, GameStatus.draw, onPressed);
    }
  }

  updateMove(context, index) {
    if (playerOTurn && playerOXMoves[index] == '') {
      playerOXMoves[index] = 'O';
      addUpBoxes += 1;
    } else if (!playerOTurn && playerOXMoves[index] == '') {
      playerOXMoves[index] = 'X';
      addUpBoxes += 1;
    }
    playerOTurn = !playerOTurn;
    void Function()? onPressed() => onPressedPlayAgain(context);
    GameStatus status = checkWinner(context, onPressed);
    if (status != GameStatus.win) {
      checkDraw(context, onPressed);
    }
    emit(RefreshBoard());
  }
}
