import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';
import 'package:game_jam_2024/game/entities/fireplace/fireplace.dart';

class LightsFiresBehavior extends Behavior<Fireplace> with KeyboardHandler {
  var timeLit = 0;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      if (parent.nearPlayer) {
        timeLit += 1;
      }
      if (timeLit > 5) {
        parent.lit = true;
      }
      return false;
    }

    return true;
  }
}
