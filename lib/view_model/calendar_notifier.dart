import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'calendar_notifier.g.dart';

@riverpod
class DaySelected extends _$DaySelected {
  @override
  DateTime build() {
    return DateTime.now();
  }
  void changeSelectedDay(DateTime focusedDay,DateTime selectedDay){
    if(focusedDay == selectedDay){
      state = selectedDay;
    }
  }
}