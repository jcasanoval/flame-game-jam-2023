import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_over_state.dart';

class GameOverCubit extends Cubit<GameOverState> {
  GameOverCubit() : super(const GameOverState());

  void endGame() {
    emit(const GameOverState(gameEnded: true));
  }
}
