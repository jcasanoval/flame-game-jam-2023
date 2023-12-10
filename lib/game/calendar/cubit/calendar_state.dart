part of 'calendar_cubit.dart';

class CalendarState extends Equatable {
  const CalendarState({
    this.day = 1,
    this.isNighttime = false,
  });

  final int day;

  final bool isNighttime;

  @override
  List<Object> get props => [day, isNighttime];
}
