import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:game_jam_2024/game/calendar/calendar.dart';
import 'package:game_jam_2024/game/game.dart';
import 'package:game_jam_2024/game_over/game_over.dart';
import 'package:game_jam_2024/gen/assets.gen.dart';

const _initialValue = 20.0;

class House extends PositionedEntity
    with
        CollisionCallbacks,
        HasGameRef<VeryGoodFlameGame>,
        FlameBlocReader<GameOverCubit, GameOverState> {
  House({
    required super.position,
  }) : super(
          anchor: Anchor.center,
          size: Vector2(128, 122),
          behaviors: [],
          priority: 20,
        );

  late SpriteComponent _spriteComponent;

  late PositionComponent _thermometer;
  final Paint _thermometerPaint = Paint()..color = _thermometerColors[0];
  static const List<Color> _thermometerColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.lightBlue
  ];

  /// Whether the house has a guest (player) inside or not.
  bool hasGuest = false;

  bool fireLit = false;
  bool isNight = false;
  double value = _initialValue;
  int day = 1;
  TextComponent debugText = TextComponent(
    textRenderer: TextPaint(style: const TextStyle(color: Colors.black)),
  );
  late Fireplace fireplace;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final sprite = await gameRef.loadSprite(
      Assets.images.winterVillage.path,
      srcSize: Vector2(128, 122),
      srcPosition: Vector2(640, 230),
    );
    _spriteComponent = SpriteComponent(
      sprite: sprite,
      size: super.size,
      anchor: Anchor.center,
    )..priority = 10;
    fireplace = Fireplace(
      position: Vector2(-30, 10),
      onLitEvent: (value) => fireLit = value,
    );

    await addAll([
      FlameBlocListener<CalendarCubit, CalendarState>(
        onNewState: (state) {
          if (day != state.day) {
            value = _initialValue;
            fireplace.lit = false;
            debugText.text = '$value';
          }
          isNight = state.isNighttime;
          day = state.day;
        },
      ),
      if (debugMode) debugText,
      _Walls(),
      _Floor(),
      _spriteComponent,
      fireplace,
      RectangleComponent(
        size: Vector2(14, 54),
        anchor: Anchor.bottomCenter,
        position: Vector2(70, 0),
        paint: Paint()..color = Colors.grey.shade700,
      ),
      _thermometer = RectangleComponent(
        size: Vector2(10, 50),
        anchor: Anchor.bottomCenter,
        position: Vector2(70, -2),
        paint: _thermometerPaint,
      ),
    ]);
  }

  @override
  void update(double dt) {
    if (hasGuest) {
      _spriteComponent.opacity = 0.2;
    } else {
      _spriteComponent.opacity = 1;
    }
    if (isNight && !fireLit) {
      value -= dt;
      debugText.text = '$value';
    }

    if (fireLit) {
      if (random.nextDouble() < 0.3) {
        add(
          ParticleSystemComponent(
            priority: 100,
            particle: AcceleratedParticle(
              lifespan: random.nextDouble() * 3,
              position: Vector2(-30 + -2 + random.nextDouble() * 2, -30),
              speed: Vector2(0, -70 + (random.nextDouble() * 10)),
              child: CircleParticle(
                radius: 10 + random.nextDouble() * 10,
                paint: Paint()..color = Colors.grey.withOpacity(0.3),
              ),
            ),
          ),
        );
      }
    }
    _thermometer.size.y = 50 * (value / _initialValue);
    _thermometerPaint.color = _thermometerColors[
        ((_thermometerColors.length - 1) * (1 - value / _initialValue))
            .floor()];
    if (value < 0) {
      bloc.endGame();
    }

    final player = gameRef.player;
    if (player.position.y + 80 > position.y + size.y / 2) {
      priority = player.priority - 1;
    } else {
      priority = player.priority + 1;
    }
  }
}

class _Floor extends PositionComponent
    with CollisionCallbacks, ParentIsA<House> {
  _Floor()
      : super(
          size: Vector2(102, 86),
          anchor: Anchor.center,
          position: Vector2(102 / 2, 84 / 2 + 15),
        );

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      parent.hasGuest = true;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Player) {
      parent.hasGuest = false;
    }
  }

  @override
  Future<void> onLoad() async {
    await addAll(
      [
        RectangleComponent(
          size: size,
          anchor: Anchor.center,
          paint: Paint()..color = const Color(0xff976744).withOpacity(0.2),
        ),
        RectangleHitbox(isSolid: true, size: size)..anchor = Anchor.center,
      ],
    );
  }
}

class _Walls extends Component {
  _Walls()
      : super(
          children: [
            // Top wall
            Wall(
              position: Vector2(125 / 2, -29),
              size: Vector2(125, 14),
            ),
            // Left wall
            Wall(
              position: Vector2(-50, 56),
              size: Vector2(12, 99),
            ),
            // Right wall
            Wall(
              position: Vector2(62, 56),
              size: Vector2(12, 99),
            ),
            // Bottom right wall
            Wall(
              position: Vector2(62, 116 / 2),
              size: Vector2(32, 2),
            ),
            // Bottom left wall
            Wall(
              position: Vector2(2, 116 / 2),
              size: Vector2(64, 2),
            ),
          ],
        );
}
