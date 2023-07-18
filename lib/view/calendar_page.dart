import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../view_model/calendar_notifier.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime selectedDay = ref.watch(daySelectedProvider);
    DateTime focusedDay = ref.watch(daySelectedProvider);
    Map<DateTime, List> _eventsList = {
      DateTime.now().add(Duration(days: 0)): ['胸', '背中'],
      DateTime.now().add(Duration(days: 2)): ['胸', '背中'],
      DateTime.now().add(Duration(days: 3)): ['胸'],
      DateTime.now().add(Duration(days: 4)): ['胸', '胸', '胸'],
    };
    int getHashCode(DateTime key) {
      return key.day * 1000000 + key.month * 10000 + key.year;
    }

    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List getEvent(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 10),
          TableCalendar(
            //土日と平日のカラーの指定
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle:
                  TextStyle().copyWith(fontSize: 10.0, color: Colors.black),
              weekendStyle:
                  TextStyle().copyWith(fontSize: 10.0, color: Colors.orange),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            locale: 'ja_JP',
            focusedDay: focusedDay,
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2031, 1, 1),
            eventLoader: getEvent,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              ref
                  .read(daySelectedProvider.notifier)
                  .changeSelectedDay(focusedDay, selectedDay);
            },
            //カレンダーで表示する日付のフォントや位置の指定
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, day, focusedDay) {
                return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            day.day.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ));
              },
              //セルに線をつけたり、セルの文字の位置や配置の指定
              defaultBuilder:
                  (BuildContext context, DateTime day, DateTime focusedDay) {
                return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.05,
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                    ));
              },
              //イベントがある場合のセルの表示の仕方を指定
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: -12,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      height: 49,
                      width: 59,
                      child: Stack(
                        children: [
                          if (events.length >= 1)
                            Positioned(
                              top: 6,
                              child: Container(
                                width: 59,
                                height: 13,
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    events[0].toString(),
                                    style: TextStyle().copyWith(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (events.length >= 2)
                            Positioned(
                              top: 21,
                              child: Container(
                                width: 59,
                                height: 13,
                                color: Colors.red,
                                child: Center(
                                  child: Text(
                                    events[1].toString(),
                                    style: TextStyle().copyWith(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
              //特定の日付を選択した時のセルの指定
              selectedBuilder:
                  (BuildContext context, DateTime day, DateTime focusedDay) {
                return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    color: Color.fromARGB(255, 223, 221, 221),
                    alignment: Alignment.topCenter,
                    child: isSameDay(selectedDay, DateTime.now())
                        ? Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                              child: Center(
                                child: Text(
                                  day.day.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ));
              },

              //カレンダーに表示される別の月の日付の指定
              outsideBuilder:
                  (BuildContext context, DateTime day, DateTime focusedDay) {
                return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.05,
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
