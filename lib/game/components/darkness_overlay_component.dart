import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/calendar/cubit/calendar_cubit.dart';

const _secondsInDayNightCycle = 10;

class DarknessOverlayComponent extends PositionComponent
    with
        FlameBlocReader<CalendarCubit, CalendarState>,
        FlameBlocListenable<CalendarCubit, CalendarState> {
  DarknessOverlayComponent({
    super.size,
  }) : super();

  final RectangleComponent rectangleComponent = RectangleComponent(
    paint: Paint()..color = Colors.black,
  );

  double value = 0;
  bool isNight = false;
  int day = 1;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size.setFrom(size);
    rectangleComponent.size = this.size;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    rectangleComponent.size = size;
    add(rectangleComponent);
  }

  @override
  void update(double dt) {
    value += dt;
    final percentageThroughNight =
        (value / _secondsInDayNightCycle).clamp(0, 1).toDouble();
    if (percentageThroughNight > 0.6 && !isNight) {
      bloc.makeNight();
    }
    if (percentageThroughNight == 1) {
      bloc.incrementDay();
    }

    final curvedValue = cubicBezier(
      Vector2.zero(),
      Vector2(0.5, 0),
      Vector2(0.5, 0.7),
      Vector2(1, 0.7),
      percentageThroughNight,
    ).y;

    rectangleComponent.setOpacity(curvedValue);
  }

  @override
  void onNewState(CalendarState state) {
    if (day != state.day) {
      value = 0;
    }
    isNight = state.isNighttime;
    day = state.day;
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
