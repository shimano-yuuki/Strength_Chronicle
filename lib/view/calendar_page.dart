import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../app.dart';
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
      DateTime.now().add(Duration(days: 4)): [
        '胸',
        '胸',
        '胸',
        '胸',
        '胸',
        '胸',
        '郁子',
        '今日は朝からジムに行き、背中と二頭筋のトレーニングを中心に行った。レットプルダウンとバーベルカールをメインに、全体的に筋力をアップさせることを目指した。日が昇るにつれて、ジムの中もエネルギーに満ちていった。今日のトレーニングは、自己ベストを更新した達成感と共に終えることができた。体は疲れているが、心は満たされている。明日もまた、自分自身に挑戦していこうと思う。'
      ],
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

    List selectedEvents = getEvent(selectedDay);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'カレンダー',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      drawer: DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          TableCalendar(
            //土日と平日のフォントサイズの指定
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle().copyWith(fontSize: 10.0),
              weekendStyle: TextStyle().copyWith(fontSize: 10.0),
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

          //予定をリスト形式で表示
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "${selectedDay.month}月${selectedDay.day}日の予定",
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: selectedEvents.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  Row(children: [
                    SizedBox(width: 15),
                    Text("11:20"),
                    SizedBox(width: 10),
                    Container(
                      width: 368,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 0.1,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Material(
                    color: Colors.transparent, // InkWellのリップルエフェクトを明確に表示するため
                    child: InkWell(
                      onTap: () {
                        print('Button tapped!');
                        // ボタンがタップされたときの振る舞いをここに書く
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Column(children: [
                          SizedBox(
                            height: 30,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 0,
                            ),
                            child: Expanded(
                              child: Center(
                                child: Text(
                                  selectedEvents[index],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ]),
                      ),
                    ),
                  ),
                ]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
