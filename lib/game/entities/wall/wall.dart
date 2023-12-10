import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Wall extends PositionedEntity with CollisionCallbacks {
  Wall({
    required super.position,
    required Vector2 size,
  }) : super(
          anchor: Anchor.center,
          size: size,
          behaviors: [],
        );

  @override
  Future<void> onLoad() async {
    await addAll([
      RectangleComponent(
        anchor: Anchor.center,
        size: size,
      ),
      RectangleHitbox(isSolid: true, size: size)..anchor = Anchor.center
    ]);
  }
}
