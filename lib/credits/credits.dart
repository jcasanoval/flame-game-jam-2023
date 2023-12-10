import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const CreditsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText('Home screen image used with permission from:'),
            SelectableText(
              'https://www.creativefabrica.com/product/winter-snow-village-landscape-pixel-art-9/',
            ),
            SelectableText('Trees, houses and logs used with permission from:'),
            SelectableText(
              'https://elv-games.itch.io/fantasy-dreamland-winter-village',
            ),
          ],
        ),
      ),
    );
  }
}
