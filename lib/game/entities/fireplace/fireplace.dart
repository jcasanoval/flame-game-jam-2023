import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/entities/fireplace/behaviors/behaviors.dart';
import 'package:game_jam_2024/game/entities/player/player.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

class Fireplace extends PositionedEntity with CollisionCallbacks, HasGameRef {
  Fireplace({
    required super.position,
    this.onLitEvent,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(20),
          behaviors: [
            LightsFiresBehavior(),
            HasFuelBehavior(),
          ],
        );

  set lit(bool value) {
    if (value == _lit) {
      return;
    }
    _lit = value;
    if (_lit) {
      // TODO(jcasanoval): play sound
      add(_fireplaceLit);
      remove(_fireplaceUnlit);
    } else {
      // TODO(jcasanoval): play sound
      add(_fireplaceUnlit);
      remove(_fireplaceLit);
    }
    onLitEvent?.call(value);
  }

  bool get lit => _lit;
  bool nearPlayer = false;

  bool _lit = false;

  final ValueSetter<bool>? onLitEvent;

  @override
  void update(double dt) {
    fireplace.paint.color = lit ? Colors.red : Colors.brown;
    super.update(dt);
  }

  RectangleComponent fireplace = RectangleComponent(
    paint: Paint()..color = Colors.brown,
    anchor: Anchor.center,
    size: Vector2(20, 20),
  );

  late SpriteAnimationComponent _fireplaceLit;
  late SpriteComponent _fireplaceUnlit;

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Player) {
      nearPlayer = true;
    }
    super.onCollision(points, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    nearPlayer = false;
    super.onCollisionEnd(other);
  }

  @override
  Future<void> onLoad() async {
    final litAnimation = await gameRef.loadSpriteAnimation(
      Assets.images.fireLit.path,
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.2,
        textureSize: Vector2.all(32),
      ),
    );
    _fireplaceLit = SpriteAnimationComponent(
      animation: litAnimation,
      size: size,
    );

    final unlitSprite = await gameRef.loadSprite(
      Assets.images.fireUnlit.path,
      // srcPosition: Vector2.all(32),
      srcSize: Vector2.all(32),
    );
    _fireplaceUnlit = SpriteComponent(
      sprite: unlitSprite,
      size: size,
    );
    await addAll([
      _fireplaceUnlit,
      RectangleHitbox()..anchor = Anchor.center,
    ]);
  }
}
