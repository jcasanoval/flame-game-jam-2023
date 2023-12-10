import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/entities/entities.dart';
import 'package:game_jam_2024/game/entities/wall/wall.dart';

class House extends PositionedEntity with CollisionCallbacks {
  House({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(96),
          behaviors: [],
          priority: 20,
        );

  @override
  Future<void> onLoad() async {
    await addAll([
      // Top wall
      Wall(
        position: Vector2(48, -43),
        size: Vector2(96, 5),
      ),
      // Left wall
      Wall(
        position: Vector2(-43, 48),
        size: Vector2(5, 96),
      ),
      // Right wall
      Wall(
        position: Vector2(48, 48),
        size: Vector2(5, 96),
      ),
      // Bottom right wall
      Wall(
        position: Vector2(48, 48),
        size: Vector2(28, 5),
      ),
      // Bottom left wall
      Wall(
        position: Vector2(-20, 48),
        size: Vector2(28, 5),
      ),
      RectangleComponent(
        paint: Paint()..color = Colors.brown,
        anchor: Anchor.center,
        position: Vector2(-33, 38),
        size: Vector2(32, 20),
      ),
      RectangleComponent(
        paint: Paint()..color = Colors.brown,
        anchor: Anchor.center,
        position: Vector2(33, 38),
        size: Vector2(32, 20),
      ),
      RectangleComponent(
        paint: Paint()..color = Colors.brown,
        anchor: Anchor.center,
        position: Vector2(0, -55),
        size: Vector2(96, 20),
      ),
      Fireplace(position: Vector2(0, -30)),
    ]);
  }
}
