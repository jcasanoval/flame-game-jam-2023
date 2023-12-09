import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';

const speed = 45.0;
const topSpeed = 125.0;
const friction = 0.7;
const minSpeed = 0.2;

class MovingBehavior<E extends PositionedEntity> extends Behavior<E>
    with KeyboardHandler {
  Vector2 velocity = Vector2.zero();
  Vector2 acceleration = Vector2.zero();

  @override
  bool containsLocalPoint(Vector2 point) {
    return parent.containsLocalPoint(point);
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocity = (acceleration.length == 0
        ? (velocity.length > minSpeed ? velocity * friction : Vector2.zero())
        : velocity + (acceleration.normalized() * speed))
      ..clampLength(0, topSpeed);
    parent.position += velocity * dt;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    var currentVelocity = Vector2.zero();
    var validKeys = false;
    if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      currentVelocity += Vector2(0, -1);
      validKeys = true;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      currentVelocity += Vector2(0, 1);
      validKeys = true;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      currentVelocity += Vector2(-1, 0);
      validKeys = true;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      currentVelocity += Vector2(1, 0);
      validKeys = true;
    }
    acceleration = currentVelocity;
    return !validKeys;
  }
}
