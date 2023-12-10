import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

class ShakeBehavior extends Behavior<Tree>
    with KeyboardHandler, HasGameRef, FlameBlocReader<AudioCubit, AudioState> {
  DateTime lastShaken = DateTime.now();

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (!keysPressed.contains(LogicalKeyboardKey.space)) return true;
    if (keysPressed.contains(LogicalKeyboardKey.space) &&
        DateTime.now().difference(lastShaken).inMilliseconds > 500 &&
        parent.nearPlayer) {
      lastShaken = DateTime.now();
      parent.shaking = true;
      bloc.effectPlayer.play(AssetSource(Assets.audio.treeShaking));
      if (Random().nextInt(3) == 1) {
        parent.game.world.add(
          Log(
            position: parent.position +
                Vector2(
                  Random().nextInt(40) - 20,
                  Random().nextInt(40) - 20,
                ),
          ),
        );
      }
    }

    return true;
  }
}
