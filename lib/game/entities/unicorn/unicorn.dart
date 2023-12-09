import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

class Unicorn extends PositionedEntity with HasGameRef, CollisionCallbacks {
  Unicorn({
    required super.position,
  }) : super(
          priority: 10,
          anchor: Anchor.center,
          size: Vector2.all(32),
          behaviors: [
            TappingBehavior(),
            MovingBehavior(),
            WallCollisionBehavior(),
            PropagatingCollisionBehavior(
              RectangleHitbox(
                isSolid: true,
                size: Vector2.all(32),
              )..paint = (Paint()..color = Colors.red),
            ),
            DropLogBehavior(),
          ],
        );

  @visibleForTesting
  Unicorn.test({
    required super.position,
    super.behaviors,
  }) : super(size: Vector2.all(32));

  late SpriteAnimationComponent _animationComponent;

  @visibleForTesting
  SpriteAnimationTicker get animationTicker =>
      _animationComponent.animationTicker!;

  @override
  Future<void> onLoad() async {
    final animation = await gameRef.loadSpriteAnimation(
      Assets.images.unicornAnimation.path,
      SpriteAnimationData.sequenced(
        amount: 16,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );

    await addAll([
      _animationComponent = SpriteAnimationComponent(
        animation: animation,
        size: size,
      ),
      RectangleHitbox(isSolid: true, size: size)
        ..debugColor = Colors.red
        ..paint = (Paint()..color = Colors.red),
    ]);

    resetAnimation();
  }

  void resetAnimation() {
    animationTicker
      ..currentIndex = animationTicker.spriteAnimation.frames.length - 1
      ..update(0.1)
      ..currentIndex = 0;
  }

  /// Plays the animation.
  void playAnimation() => animationTicker.reset();

  /// Returns whether the animation is playing or not.
  bool isAnimationPlaying() => !animationTicker.done();
}
