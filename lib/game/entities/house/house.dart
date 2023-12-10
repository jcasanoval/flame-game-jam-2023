import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/calendar/calendar.dart';
import 'package:game_jam_2024/game/entities/entities.dart';
import 'package:game_jam_2024/game/entities/wall/wall.dart';

const _initialValue = 20.0;

class House extends PositionedEntity
    with CollisionCallbacks, FlameBlocListenable<CalendarCubit, CalendarState> {
  House({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(96),
          behaviors: [],
          priority: 20,
        );

  bool fireLit = false;
  bool isNight = false;
  double value = _initialValue;
  int day = 1;

  TextComponent debugText = TextComponent(
    textRenderer: TextPaint(style: const TextStyle(color: Colors.black)),
  );
  late Fireplace fireplace;

  @override
  Future<void> onLoad() async {
    debugText.text = '$value';
    fireplace = Fireplace(
      position: Vector2(0, -30),
      onLitEvent: (value) => fireLit = value,
    );

    await addAll([
      if (debugMode) debugText,
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
      fireplace,
    ]);
  }

  @override
  void update(double dt) {
    if (isNight && !fireLit) {
      value -= dt;
      debugText.text = '$value';
    }
    if (value < 0) {
      // TODO: loose here
    }
  }

  @override
  void onNewState(CalendarState state) {
    if (day != state.day) {
      value = _initialValue;
      fireplace.lit = false;
      debugText.text = '$value';
    }
    isNight = state.isNighttime;
    day = state.day;
  }
}
