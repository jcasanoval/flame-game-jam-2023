part of 'calendar_cubit.dart';

class CalendarState extends Equatable {
  const CalendarState({
    this.day = 1,
  });

  final int day;

  @override
  List<Object> get props => [day];
}
