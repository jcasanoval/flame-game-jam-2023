import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

final _random = math.Random(0);

class Forest extends PositionComponent {
  Forest({
    required this.villageSize,
    this.treeDensity = 150,
    super.position,
  });

  final Vector2 villageSize;
  final int treeDensity;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    const treeDensity = 100;
    final randomTrees = <Tree>[];

    final treeSize = Vector2(64, 64);

    for (var i = 0; i < treeDensity; i++) {
      final randomAngle = _random.nextDouble() * 2 * math.pi;
      final randomRadius = (_random.nextDouble() + 1) *
          villageSize.x /
          2; // Ensure trees are outside the village

      // Convert polar coordinates to Cartesian coordinates
      final randomX = randomRadius * math.cos(randomAngle);
      final randomY = randomRadius * math.sin(randomAngle);

      // Create and add a tree at the calculated coordinates
      final tree = Tree()
        ..position = Vector2(randomX, randomY)
        ..size = treeSize;

      // Check for collisions with existing trees
      var treeCollides = false;
      for (final existingTree in randomTrees) {
        if (tree.position.distanceTo(existingTree.position) < treeSize.x) {
          treeCollides = true;
          break;
        }
      }

      // If there is a collision, try placing the tree again
      if (treeCollides) {
        i--;
        continue;
      }

      // Add the tree to the list if there is no collision
      randomTrees.add(tree);
    }
    addAll(randomTrees);
  }
}

class Tree extends PositionComponent with HasGameRef<VeryGoodFlameGame> {
  Tree({
    super.position,
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
