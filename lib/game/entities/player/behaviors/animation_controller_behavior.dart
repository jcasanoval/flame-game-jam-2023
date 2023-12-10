import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:game_jam_2024/game/entities/entities.dart';
import 'package:game_jam_2024/game/entities/player/behaviors/behaviors.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

class AnimationControllerBehavior extends Behavior<Player> with HasGameRef {
  AnimationState _state = AnimationState.idle;
  AnimationDirection _direction = AnimationDirection.down;

  late SpriteAnimationComponent _downWalkComponent;
  late SpriteAnimationComponent _upWalkComponent;
  late SpriteAnimationComponent _leftWalkComponent;
  late SpriteAnimationComponent _rightWalkComponent;

  late SpriteComponent _downIdleComponent;
  late SpriteComponent _upIdleComponent;
  late SpriteComponent _leftIdleComponent;
  late SpriteComponent _rightIdleComponent;

  @override
  Future<void> onLoad() async {
    await _loadWalkingAnimations();
    await _loadIdleAnimations();

    parent.add(_downIdleComponent);
  }

  Future<void> _loadWalkingAnimations() async {
    final downWalk = await gameRef.loadSpriteAnimation(
      Assets.images.playerCharacter.path,
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.1,
        textureSize: Vector2(32, 64),
        texturePosition: Vector2(32, 0),
      ),
    );
    _downWalkComponent = SpriteAnimationComponent(
      animation: downWalk,
      size: Vector2(32, 64),
    );

    final upWalk = await gameRef.loadSpriteAnimation(
      Assets.images.playerCharacter.path,
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.1,
        textureSize: Vector2(32, 64),
        texturePosition: Vector2(32, 128),
      ),
    );
    _upWalkComponent = SpriteAnimationComponent(
      animation: upWalk,
      size: Vector2(32, 64),
    );

    final sideWalk = await gameRef.loadSpriteAnimation(
      Assets.images.playerCharacter.path,
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.1,
        textureSize: Vector2(32, 64),
        texturePosition: Vector2(32, 64),
      ),
    );
    _leftWalkComponent = SpriteAnimationComponent(
      animation: sideWalk,
      size: Vector2(32, 64),
    );
    _rightWalkComponent = SpriteAnimationComponent(
      animation: sideWalk,
      size: Vector2(32, 64),
      position: Vector2(32, 0),
    )..flipHorizontally();
  }

  Future<void> _loadIdleAnimations() async {
    final downIdle = await gameRef.loadSprite(
      Assets.images.playerCharacter.path,
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(32, 64),
    );
    _downIdleComponent = SpriteComponent(
      sprite: downIdle,
      size: Vector2(32, 64),
    );

    final upIdle = await gameRef.loadSprite(
      Assets.images.playerCharacter.path,
      srcPosition: Vector2(0, 128),
      srcSize: Vector2(32, 64),
    );
    _upIdleComponent = SpriteComponent(
      sprite: upIdle,
      size: Vector2(32, 64),
    );

    final sideIdle = await gameRef.loadSprite(
      Assets.images.playerCharacter.path,
      srcPosition: Vector2(0, 64),
      srcSize: Vector2(32, 64),
    );
    _leftIdleComponent = SpriteComponent(
      sprite: sideIdle,
      size: Vector2(32, 64),
    );
    _rightIdleComponent = SpriteComponent(
      sprite: sideIdle,
      size: Vector2(32, 64),
      position: Vector2(32, 0),
    )..flipHorizontally();
  }

  @override
  void update(double dt) {
    final velocity = parent.findBehavior<MovingBehavior>().velocity;
    late AnimationState newState;
    late AnimationDirection newDirection;

    if (velocity.x == 0 && velocity.y == 0) {
      newState = AnimationState.idle;
    } else {
      newState = AnimationState.walk;
    }

    if (newState == AnimationState.idle) {
      newDirection = _direction;
    } else {
      if (velocity.x.abs() > velocity.y.abs()) {
        if (velocity.x > 0) {
          newDirection = AnimationDirection.right;
        } else {
          newDirection = AnimationDirection.left;
        }
      } else {
        if (velocity.y > 0) {
          newDirection = AnimationDirection.down;
        } else {
          newDirection = AnimationDirection.up;
        }
      }
    }

    if (_state != newState || _direction != newDirection) {
      final oldAnimation = mapAnimation(_state, _direction);
      final newAnimation = mapAnimation(newState, newDirection);
      parent
        ..add(newAnimation)
        ..remove(oldAnimation);
      _state = newState;
      _direction = newDirection;
    }
  }

  Component mapAnimation(AnimationState state, AnimationDirection direction) {
    switch (state) {
      case AnimationState.idle:
        return _mapIdleAnimation(direction);
      case AnimationState.walk:
        return _mapWalkAnimation(direction);
    }
  }

  Component _mapIdleAnimation(AnimationDirection direction) {
    switch (direction) {
      case AnimationDirection.down:
        return _downIdleComponent;
      case AnimationDirection.up:
        return _upIdleComponent;
      case AnimationDirection.left:
        return _leftIdleComponent;
      case AnimationDirection.right:
        return _rightIdleComponent;
    }
  }

  Component _mapWalkAnimation(AnimationDirection direction) {
    switch (direction) {
      case AnimationDirection.down:
        return _downWalkComponent;
      case AnimationDirection.up:
        return _upWalkComponent;
      case AnimationDirection.left:
        return _leftWalkComponent;
      case AnimationDirection.right:
        return _rightWalkComponent;
    }
  }
}

enum AnimationState { idle, walk }

enum AnimationDirection {
  down,
  up,
  left,
  right,
}
