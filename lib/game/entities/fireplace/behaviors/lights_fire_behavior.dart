import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:game_jam_2024/game/entities/fireplace/behaviors/behaviors.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

class LightsFiresBehavior extends Behavior<Fireplace>
    with KeyboardHandler, FlameBlocReader<AudioCubit, AudioState> {
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
      if (parent.lit) {
        bloc.effectPlayer.play(AssetSource(Assets.audio.fireLitUp));
      } else {
        bloc.effectPlayer.play(AssetSource(Assets.audio.flint));
      }
    }

    return true;
  }
}
