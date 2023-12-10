import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/calendar/cubit/calendar_cubit.dart';
import 'package:game_jam_2024/game/entities/house/house.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/game_over/game_over.dart';
import 'package:game_jam_2024/l10n/l10n.dart';

final Random random = Random();

class VeryGoodFlameGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  VeryGoodFlameGame({
    required this.l10n,
    required this.effectPlayer,
    required this.textStyle,
    required InventoryBloc inventoryBloc,
    required GameOverCubit gameOverCubit,
  })  : _inventoryBloc = inventoryBloc,
        _gameOverCubit = gameOverCubit {
    images.prefix = '';
  }

  @override
  bool get debugMode => false;

  final InventoryBloc _inventoryBloc;
  final GameOverCubit _gameOverCubit;

  final AppLocalizations l10n;

  final AudioPlayer effectPlayer;

  final TextStyle textStyle;

  @override
  late final World world;

  late Player player;

  int counter = 0;

  @override
  Color backgroundColor() => Colors.blue.shade50;

  @override
  Future<void> onLoad() async {
    world = World(
      children: [
        player = Player(position: Vector2(66, 608)),
        House(position: Vector2(960, 544)),
        House(position: Vector2(178, 98)),
        House(position: Vector2(860, 124)),
        House(position: Vector2(160, 600)),
        House(position: Vector2(500, 400)),
        Tree(position: Vector2(80, 380)),
        Tree(position: Vector2(140, 400)),
        Tree(position: Vector2(30, 440)),
      ],
    );

    final camera = CameraComponent(world: world);

    await addAll([
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<InventoryBloc, InventoryState>.value(
            value: _inventoryBloc,
          ),
          FlameBlocProvider<CalendarCubit, CalendarState>(
            create: CalendarCubit.new,
          ),
          FlameBlocProvider<GameOverCubit, GameOverState>.value(
            value: _gameOverCubit,
          )
        ],
        children: [world, camera],
      ),
    ]);

    camera.viewfinder.position = size / 2;
    camera.viewfinder.zoom = 2;
    camera.follow(player);
    await camera.viewport.addAll([
      DarknessOverlayComponent(size: size),
      DayIndicator(),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    camera.viewport.add(
      ParticleSystemComponent(
        particle: AcceleratedParticle(
          lifespan: random.nextDouble() * 20,
          position: Vector2(random.nextDouble() * canvasSize.x, 0),
          speed: Vector2(0, 70 + (random.nextDouble() * 10)),
          child: CircleParticle(
            radius: 2,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );
  }
}
