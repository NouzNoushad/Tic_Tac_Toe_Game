import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tic_tac_toe/cubit/tic_tac_toe_cubit.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late TicTacToeCubit ticTacToeCubit;
  @override
  void initState() {
    ticTacToeCubit = BlocProvider.of<TicTacToeCubit>(context);
    ticTacToeCubit.initPlayers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 81, 27, 90),
      body: SafeArea(
        child: BlocBuilder<TicTacToeCubit, TicTacToeState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          playerDetails('Player O',
                              ticTacToeCubit.playerOScore.toString()),
                          playerDetails('Player X',
                              ticTacToeCubit.playerXScore.toString()),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GridView.builder(
                              itemCount: 9,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      ticTacToeCubit.updateMove(context, index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.purple.shade200)),
                                      child: Center(
                                        child: Text(
                                          ticTacToeCubit.playerOXMoves[index],
                                          style: const TextStyle(
                                              fontSize: 50,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )),
                          TextButton(
                              onPressed: () {
                                ticTacToeCubit.resetGame();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Reset Game',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.purple,
                                ),
                              )),
                        ],
                      ),
                    )),
                Expanded(
                  child: Center(
                    child: Text(
                      'Tic Tac Toe',
                      style: TextStyle(
                          fontSize: 20, color: Colors.purple.shade200),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget playerDetails(String title, String score) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                letterSpacing: 2,
                fontSize: 20,
                color: Colors.purple.shade200,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            score,
            style: const TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      );
}
