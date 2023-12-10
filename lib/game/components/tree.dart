import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:game_jam_2024/game/entities/wall/wall.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

class Tree extends PositionComponent with HasGameRef<VeryGoodFlameGame> {
  Tree({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2(64, 64),
          priority: 11,
        );

  late SpriteComponent _spriteComponent;

  @override
  FutureOr<void> onLoad() async {
    final sprite = await gameRef.loadSprite(
      Assets.images.winterVillage.path,
      srcSize: Vector2(64, 64),
      srcPosition: Vector2(192, 64),
    );
    _spriteComponent = SpriteComponent(
      sprite: sprite,
      size: super.size,
      anchor: Anchor.center,
    )..priority = 10;

    await addAll(
      [
        _spriteComponent,
        Wall(position: Vector2(10, 30), size: Vector2(20, 10)),
        SpawnComponent.periodRange(
          factory: (_) => Log(position: position),
          maxPeriod: 15,
          minPeriod: 5,
          area: Circle(Vector2(0, 50), 50),
        )
      ],
    );
  }
}
