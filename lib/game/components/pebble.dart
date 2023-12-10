import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:game_jam_2024/game/game_jam_2024.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

final _random = math.Random();

class Pebble extends PositionComponent with HasGameRef<VeryGoodFlameGame> {
  Pebble({super.position});

  static final Set<Vector2> _spriteSrcPositions = {
    Vector2(0, 256),
    Vector2(32, 256),
    Vector2(64, 256),
    Vector2(96, 256),
    Vector2(128, 256),
    Vector2(160, 256),
    Vector2(192, 256),
    Vector2(224, 256),
    Vector2(256, 256),
    Vector2(288, 256),
    Vector2(320, 256),
    Vector2(352, 256),
    Vector2(0, 288),
    Vector2(32, 288),
    Vector2(64, 288),
    Vector2(96, 288),
    Vector2(128, 288),
    Vector2(160, 288),
    Vector2(192, 288),
    Vector2(224, 288),
    Vector2(256, 288),
    Vector2(288, 288),
    Vector2(320, 288),
    Vector2(352, 288),
  };

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    final sprite = await gameRef.loadSprite(
      Assets.images.winterVillage.path,
      srcSize: Vector2(32, 32),
      srcPosition: _spriteSrcPositions.elementAt(
        _random.nextInt(_spriteSrcPositions.length),
      ),
    );

    await addAll([
      SpriteComponent(
        sprite: sprite,
        size: super.size,
        anchor: Anchor.center,
      )..priority = 10,
    ]);
  }
}
