import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/entities/fireplace/behaviors/behaviors.dart';
import 'package:game_jam_2024/game/entities/unicorn/unicorn.dart';

class Fireplace extends PositionedEntity with CollisionCallbacks {
  Fireplace({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(20),
          behaviors: [
            LightsFiresBehavior(),
          ],
        );

  bool lit = false;
  bool nearPlayer = false;

  @override
  void update(double dt) {
    fireplace.paint.color = lit ? Colors.red : Colors.white;
    super.update(dt);
  }

  RectangleComponent fireplace = RectangleComponent(
    paint: Paint()..color = Colors.white,
    anchor: Anchor.center,
    size: Vector2(20, 20),
  );

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Unicorn) {
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
  FutureOr<void> onLoad() {
    addAll([
      fireplace,
      RectangleHitbox()..anchor = Anchor.center,
    ]);
  }
}
