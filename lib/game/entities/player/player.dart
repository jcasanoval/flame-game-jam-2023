import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/entities/player/behaviors/behaviors.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

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

  late SpriteAnimationComponent _spaceHint;

  List<Component> interactableComponents = [];

  @override
  Future<void> onLoad() async {
    _spaceHint = SpriteAnimationComponent(
      animation: await gameRef.loadSpriteAnimation(
        Assets.images.spaceHint.path,
        SpriteAnimationData.sequenced(
          amount: 2,
          stepTime: 0.5,
          textureSize: Vector2.all(32),
        ),
      ),
      size: Vector2.all(32),
      position: Vector2(0, -32),
      priority: 100,
    );
    await super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    if (other is Fireplace || other is Tree || other is Log) {
      if (interactableComponents.isEmpty) {
        add(_spaceHint);
      }
      interactableComponents.add(other);
    }
    super.onCollisionStart(points, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (interactableComponents.contains(other)) {
      interactableComponents.remove(other);
      if (interactableComponents.isEmpty) {
        remove(_spaceHint);
      }
    }
    super.onCollisionEnd(other);
  }

  @visibleForTesting
  Player.test({
    required super.position,
    super.behaviors,
  }) : super(size: Vector2.all(32));
}
