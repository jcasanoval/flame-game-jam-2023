import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:game_jam_2024/game/entities/house/wall.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/l10n/l10n.dart';

class VeryGoodFlameGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  VeryGoodFlameGame({
    required this.l10n,
    required this.effectPlayer,
    required this.textStyle,
    required InventoryBloc inventoryBloc,
  }) : _inventoryBloc = inventoryBloc {
    images.prefix = '';
  }

  final InventoryBloc _inventoryBloc;

  final AppLocalizations l10n;

  final AudioPlayer effectPlayer;

  final TextStyle textStyle;

  late final World world;

  int counter = 0;

  @override
  Color backgroundColor() => const Color(0xFFFEFEFE);

  @override
  Future<void> onLoad() async {
    world = World(
      children: [
        Log(position: (size / 2) + Vector2(50, 0)),
        Log(position: (size / 2) + Vector2(150, -50)),
        Log(position: (size / 2) + Vector2(-35, -50)),
        Unicorn(position: size / 2),
        Tree(position: (size / 2) + Vector2(-150, 0)),
        Tree(position: (size / 2) + Vector2(-180, 20)),
        Fireplace(position: (size / 2)..sub(Vector2(20, 20))),
        Wall(position: (size / 2)..add(Vector2(0, 50))),
        Wall(position: (size / 2)..add(Vector2(20, 50))),
      ],
    );

    final camera = CameraComponent(world: world);
    await addAll([
      FlameBlocProvider<InventoryBloc, InventoryState>.value(
        value: _inventoryBloc,
        children: [world],
      ),
      camera,
    ]);

    camera.viewfinder.position = size / 2;
    camera.viewfinder.zoom = 2;
  }
}
