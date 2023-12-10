import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/game.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const TitlePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/title.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const SafeArea(child: TitleView()),
        ],
      ),
    );
  }
}

class TitleView extends StatelessWidget {
  const TitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpriteButton.asset(
        onPressed: () {
          Navigator.of(context).pushReplacement<void, void>(GamePage.route());
        },
        label: const Icon(
          Icons.play_arrow,
          color: Color(0xFF5D275D),
          size: 120,
        ),
        path: 'sign.png',
        pressedPath: 'sign.png',
        width: 425,
        height: 161,
      ),
    );
  }
}
