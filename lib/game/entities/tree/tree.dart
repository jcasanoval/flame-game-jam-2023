import 'dart:async';
import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:game_jam_2024/game/entities/tree/behaviors/behaviors.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

final _random = math.Random(0);

class Forest extends PositionComponent with HasGameRef {
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
      final randomX = randomRadius * math.cos(randomAngle) + position.x;
      final randomY = randomRadius * math.sin(randomAngle) + position.y;

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
    game.world.addAll(randomTrees);
  }
}

class Tree extends PositionedEntity
    with HasGameRef<VeryGoodFlameGame>, CollisionCallbacks {
  Tree({
    super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2(64, 64),
          priority: 11,
          behaviors: [
            ShakeBehavior(),
          ],
        );

  late SpriteComponent _spriteComponent;
  bool nearPlayer = false;

  set shaking(bool value) {
    _shaking = value;
    if (value) lastShaken = DateTime.now();
  }

  DateTime lastShaken = DateTime.now();
  bool _shaking = false;

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
        CircleHitbox(radius: 35, anchor: Anchor.center),
      ],
    );
  }

  @override
  void update(double dt) {
    final player = gameRef.player;
    if (player.position.y + 64 > position.y + size.y / 2) {
      priority = player.priority - 1;
    } else {
      priority = player.priority + 1;
    }

    if (_shaking) {
      _spriteComponent.angle = pingPong(
            DateTime.now().millisecondsSinceEpoch / 1000,
            0.1,
          ) -
          0.05;
      if (DateTime.now().difference(lastShaken).inMilliseconds > 500) {
        _shaking = false;
      }
    } else {
      _spriteComponent.angle = 0;
    }
  }

  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    if (other is Player) {
      nearPlayer = true;
    }
    super.onCollisionStart(points, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Player) {
      nearPlayer = false;
    }
    super.onCollisionEnd(other);
  }
}

double pingPong(double value, double range) {
  final mod = value % range;
  final result = mod;
  return result.abs();
}
