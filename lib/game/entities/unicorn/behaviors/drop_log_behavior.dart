import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:game_jam_2024/game/game.dart';

/// {@template DropLogBehavior}
/// A behavior that allows the [Unicorn] to drop a log, if it has some
/// in its inventory.
/// {@endtemplate}
class DropLogBehavior extends Behavior<Unicorn>
    with
        KeyboardHandler,
        FlameBlocReader<InventoryBloc, InventoryState>,
        HasGameRef<VeryGoodFlameGame> {
  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.keyQ)) {
      if (bloc.state.logs > 0) {
        bloc.add(const LogRemovedInventoryEvent());

        final world = gameRef.world;
        final log = Log(position: parent.position.clone());
        world.add(log);
      }
    }

    return true;
  }
}
