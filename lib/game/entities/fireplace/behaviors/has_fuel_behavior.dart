import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:game_jam_2024/game/entities/entities.dart';
import 'package:game_jam_2024/game/inventory/bloc/inventory_bloc.dart';

class HasFuelBehavior extends Behavior<Fireplace>
    with KeyboardHandler, FlameBlocReader<InventoryBloc, InventoryState> {
  HasFuelBehavior();

  double fuel = 0;

  @override
  void update(double dt) {
    if (parent.lit) {
      fuel -= dt;
      if (fuel <= 0) {
        parent.lit = false;
      }
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      if (parent.nearPlayer && !bloc.state.isEmpty) {
        bloc.add(const LogRemovedInventoryEvent());
        fuel += 100;
      }
    }

    return true;
  }
}
