import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/game.dart';

export 'behaviors/behaviors.dart';

class Log extends PositionedEntity with CollisionCallbacks {
  Log({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2(10, 5),
          behaviors: [
            PickableLogBehavior(),
          ],
        );

  /// Wether the log is near the player or not.
  ///
  /// The log is considered to be near the player if the player is colliding with
  /// it.
  bool nearPlayer = false;

  @override
  void update(double dt) {
    log.paint.color = nearPlayer ? Colors.brown : Colors.brown[300]!;
    super.update(dt);
  }

  late final log = RectangleComponent(
    paint: Paint(),
    anchor: Anchor.center,
    size: super.size,
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
      log,
      RectangleHitbox()
        ..anchor = Anchor.center
        ..isSolid = true,
    ]);
  }
}
