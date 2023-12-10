part of 'game_over_cubit.dart';

class GameOverState extends Equatable {
  const GameOverState({
    this.gameEnded = false,
  });

  final bool gameEnded;

  @override
  List<Object> get props => [gameEnded];
}
