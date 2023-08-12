import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/core/constant.dart';

showWinnerDialog(String text, BuildContext context, GameStatus status,
    void Function()? onPressed) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: const Color.fromARGB(255, 81, 27, 90),
            title: Center(
              child: Text(
                status == GameStatus.win ? 'Winner: $text' : 'Oops Draw',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purple.shade100,
                  ),
                  child: const Text(
                    'Play again',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                    ),
                  )),
            ],
          ));
}
