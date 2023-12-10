import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

export 'behaviors/behaviors.dart';

class Log extends PositionedEntity
    with CollisionCallbacks, HasGameRef<VeryGoodFlameGame> {
  Log({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2(26, 32),
          behaviors: [
            PickableLogBehavior(),
          ],
        );

  /// Wether the log is near the player or not.
  ///
  /// The log is considered to be near the player if the player is colliding with
  /// it.
  bool nearPlayer = false;

  @override
  void update(double dt) {
    _spriteComponent.opacity = nearPlayer ? 0.7 : 1;
    super.update(dt);
  }

  late SpriteComponent _spriteComponent;

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Unicorn) {
      nearPlayer = true;
    }
    super.onCollision(points, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    nearPlayer = false;
    super.onCollisionEnd(other);
  }

  @override
  FutureOr<void> onLoad() async {
    final sprite = await gameRef.loadSprite(
      Assets.images.winterVillage.path,
      srcSize: Vector2(26, 32),
      srcPosition: Vector2(834, 256),
    );

    await addAll([
      _spriteComponent = SpriteComponent(
        sprite: sprite,
        size: super.size,
        anchor: Anchor.center,
      ),
      RectangleHitbox()
        ..anchor = Anchor.center
        ..isSolid = true,
    ]);
  }
}
