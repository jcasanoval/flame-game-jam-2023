import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Wall extends PositionedEntity with CollisionCallbacks {
  Wall({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: hitBoxSize,
          behaviors: [],
        );

  static final hitBoxSize = Vector2(20, 5);

  @override
  Future<void> onLoad() async {
    final hitPaint = Paint()..color = Colors.red;
    await addAll([
      RectangleComponent(
        paint: Paint()..color = Color(0xFFA9A9A9),
        anchor: Anchor.center,
        size: Vector2(20, 5),
      ),
      RectangleHitbox(isSolid: true, size: hitBoxSize)
        ..anchor = Anchor.center
        ..paint = hitPaint,
    ]);
  }
}
