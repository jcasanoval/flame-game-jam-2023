import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:game_jam_2024/game/game_jam_2024.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

final _random = math.Random();

class Snow extends PositionComponent with HasGameRef<VeryGoodFlameGame> {
  Snow({super.position});

  static final Set<Vector2> _snowSpriteSrcPositions = {
    Vector2(32, 64),
    Vector2(64, 64),
    Vector2(96, 64),
    Vector2(128, 64),
    Vector2(160, 64),
    Vector2(0, 96),
    Vector2(32, 96),
    Vector2(64, 96),
    Vector2(96, 96),
    Vector2(128, 96),
    Vector2(160, 96),
    Vector2(32, 0),
    Vector2(64, 0),
    Vector2(96, 0),
    Vector2(128, 0),
    Vector2(160, 0),
    Vector2(0, 32),
    Vector2(32, 32),
    Vector2(64, 32),
    Vector2(96, 32),
    Vector2(128, 32),
    Vector2(160, 32),
  };

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    final sprite = await gameRef.loadSprite(
      Assets.images.winterVillage.path,
      srcSize: Vector2(32, 32),
      srcPosition: _snowSpriteSrcPositions.elementAt(
        _random.nextInt(_snowSpriteSrcPositions.length),
      ),
    );

    final ticker = TimerComponent(
      repeat: true,
      period: _random.nextDouble() * 60 + 30,
      onTick: () {
        final newSpriteSrcPosition = _snowSpriteSrcPositions.elementAt(
          _random.nextInt(_snowSpriteSrcPositions.length),
        );
        sprite.srcPosition = newSpriteSrcPosition;
      },
    );

    await addAll([
      SpriteComponent(
        sprite: sprite,
        size: super.size,
        anchor: Anchor.center,
      )..priority = 10,
      ticker,
    ]);
  }
}
