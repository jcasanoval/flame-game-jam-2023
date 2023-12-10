import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

const _secondsInDayNightCycle = 300;

class DarknessOverlayComponent extends PositionComponent {
  DarknessOverlayComponent({
    super.size,
  }) : super();

  final RectangleComponent rectangleComponent = RectangleComponent(
    paint: Paint()..color = Colors.black,
  );

  double value = 0;

  @override
  FutureOr<void> onLoad() {
    rectangleComponent.size = size;
    add(rectangleComponent);
  }

  @override
  void update(double dt) {
    value += dt;
    final percentageThroughNight =
        (value / _secondsInDayNightCycle).clamp(0, 0.9).toDouble();
    final curvedValue = cubicBezier(
      Vector2.zero(),
      Vector2(0.5, 0),
      Vector2(0.5, 0.7),
      Vector2(1, 0.7),
      percentageThroughNight,
    ).y;

    rectangleComponent.setOpacity(curvedValue);
  }

  Vector2 cubicBezier(
    Vector2 p0,
    Vector2 p1,
    Vector2 p2,
    Vector2 p3,
    double t,
  ) {
    final u = 1 - t;
    final tt = t * t;
    final uu = u * u;
    final uuu = uu * u;
    final ttt = tt * t;

    final x = uuu * p0.x + 3 * uu * t * p1.x + 3 * u * tt * p2.x + ttt * p3.x;
    final y = uuu * p0.y + 3 * uu * t * p1.y + 3 * u * tt * p2.y + ttt * p3.y;

    return Vector2(x, y);
  }
}
