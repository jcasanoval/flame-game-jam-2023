import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:game_jam_2024/game/entities/wall/wall.dart';
import 'package:game_jam_2024/game/game.dart';

class WallCollisionBehavior extends CollisionBehavior<Wall, Unicorn> {
  Set<Wall> collidedWalls = {};

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, Wall other) {
    collidedWalls.add(other);
  }

  @override
  void onCollisionEnd(Wall other) {
    collidedWalls.remove(other);
  }

  Vector2 restrictVelocity(Vector2 velocity) {
    collidedWalls.forEach((wall) {
      final topEdge = wall.absoluteTopLeftPosition.y - wall.size.y / 2;
      final playerBottomEdge = parent.position.y + parent.size.y / 2;
      final bottomDistance = (topEdge - playerBottomEdge).abs();

      final bottomEdge = wall.absoluteTopLeftPosition.y + wall.size.y / 2;
      final playerTopEdge = parent.position.y - parent.size.y / 2;
      final topDistance = (bottomEdge - playerTopEdge).abs();

      final leftEdge = wall.absoluteTopLeftPosition.x - wall.size.x / 2;
      final playerRightEdge = parent.position.x + parent.size.x / 2;
      final rightDistance = (leftEdge - playerRightEdge).abs();

      final rightEdge = wall.absoluteTopLeftPosition.x + wall.size.x / 2;
      final playerLeftEdge = parent.position.x - parent.size.x / 2;
      final leftDistance = (rightEdge - playerLeftEdge).abs();

      final min = [
        bottomDistance,
        topDistance,
        leftDistance,
        rightDistance,
      ].reduce((value, element) => value < element ? value : element);

      if (min == bottomDistance && velocity.y > 0) {
        parent.position.y -= 0.1;
        velocity.y = 0;
      }

      if (min == topDistance && velocity.y < 0) {
        parent.position.y += 0.1;
        velocity.y = 0;
      }

      if (min == leftDistance && velocity.x < 0) {
        parent.position.x += 0.1;
        velocity.x = 0;
      }

      if (min == rightDistance && velocity.x > 0) {
        parent.position.x -= 0.1;
        velocity.x = 0;
      }
    });
    return velocity;
  }
}
