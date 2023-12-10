import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/calendar/cubit/calendar_cubit.dart';

class DayIndicator extends PositionComponent
    with
        FlameBlocListenable<CalendarCubit, CalendarState>,
        FlameBlocReader<CalendarCubit, CalendarState> {
  DayIndicator() : super(position: Vector2.all(16));

  TextComponent textComponent = TextComponent(
    textRenderer: TextPaint(
      style: const TextStyle(
        fontSize: 48,
        color: Colors.black,
      ),
    ),
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    textComponent.text = '${bloc.state.day}';
    add(textComponent);
  }

  @override
  void onNewState(CalendarState state) {
    textComponent.text = '${state.day}';
  }
}
