import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(const CalendarState());

  void incrementDay() => emit(CalendarState(day: state.day + 1));
}
