import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:game_jam_2024/game/game.dart';

/// {@template PickableBehavior}
/// A behavior that allows the entity to be picked up by the player.
///
/// Once the entity is picked up, it will be removed from the game.
/// {@endtemplate}
class PickableLogBehavior extends Behavior<Log>
    with KeyboardHandler, FlameBlocReader<InventoryBloc, InventoryState> {
  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // FIXME(alestiago): If many logs are close to each other, the player
    // will pick up all of them at once.If so, some logs will be picked up even
    // if the inventory is full and will be lost forever.
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      if (parent.nearPlayer && !bloc.state.isFull) {
        bloc.add(const LogAddedInventoryEvent());
        parent.parent?.remove(parent);
      }
    }

    return true;
  }
}
