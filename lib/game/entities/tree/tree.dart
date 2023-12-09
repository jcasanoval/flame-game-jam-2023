import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:game_jam_2024/game/entities/wall/wall.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

class Tree extends PositionedEntity with HasGameRef<VeryGoodFlameGame> {
  Tree({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2(60, 60),
          behaviors: [],
          priority: 11,
        );

  /// Wether the log is near the player or not.
  ///
  /// The log is considered to be near the player if the player is colliding with
  /// it.
  bool nearPlayer = false;

  late SpriteComponent _spriteComponent;

  @override
  FutureOr<void> onLoad() async {
    final sprite = await gameRef.loadSprite(
      Assets.images.tree.path,
      srcSize: Vector2(96, 96),
    );

    await addAll([
      _spriteComponent = SpriteComponent(
        sprite: sprite,
        size: super.size,
        anchor: Anchor.center,
      )..priority = 10,
      Wall(position: Vector2(10, 30), size: Vector2(20, 10)),
    ]);
  }
}
