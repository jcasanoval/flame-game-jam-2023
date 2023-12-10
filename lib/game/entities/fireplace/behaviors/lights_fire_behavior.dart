import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';
import 'package:game_jam_2024/game/entities/fireplace/behaviors/behaviors.dart';
import 'package:game_jam_2024/game/entities/fireplace/fireplace.dart';

class LightsFiresBehavior extends Behavior<Fireplace> with KeyboardHandler {
  DateTime lastLit = DateTime.now();

  int timesLit = 0;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final hasFuel = parent.findBehavior<HasFuelBehavior>().fuel > 0;
    if (keysPressed.contains(LogicalKeyboardKey.space) &&
        parent.nearPlayer &&
        !parent.lit &&
        DateTime.now().difference(lastLit).inSeconds > 1 &&
        hasFuel) {
      parent.lit = Random().nextInt(6) + timesLit >= 6;
      lastLit = DateTime.now();
      timesLit++;
    }

    return true;
  }
}
