import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/entities/unicorn/behaviors/behaviors.dart';

class Player extends PositionedEntity with HasGameRef, CollisionCallbacks {
  Player({
    required super.position,
  }) : super(
          priority: 10,
          anchor: Anchor.center,
          size: Vector2(32, 64),
          behaviors: [
            MovingBehavior(),
            WallCollisionBehavior(),
            DropLogBehavior(),
            AnimationControllerBehavior(),
            PropagatingCollisionBehavior(
              RectangleHitbox(
                position: Vector2(16, 48),
                isSolid: true,
                size: Vector2.all(16),
                anchor: Anchor.center,
              ),
            ),
          ],
        );

  @visibleForTesting
  Player.test({
    required super.position,
    super.behaviors,
  }) : super(size: Vector2.all(32));

  @override
  Future<void> onLoad() async {}
}
