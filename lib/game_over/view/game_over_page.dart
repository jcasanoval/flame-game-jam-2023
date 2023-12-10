import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/game.dart';

class GameOverPage extends StatelessWidget {
  const GameOverPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const GameOverPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '🥶🥶🥶🥶',
                style: TextStyle(fontSize: 36),
              ),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement<void, void>(GamePage.route());
                },
                icon: const Icon(Icons.refresh),
                iconSize: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
