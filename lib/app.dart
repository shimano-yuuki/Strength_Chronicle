import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workout_app/view/calendar_page.dart';
import 'package:workout_app/view/diary_page.dart';
import 'package:workout_app/view/memo_page.dart';

part 'app.g.dart';

@riverpod
class SelectedBottomNavigation extends _$SelectedBottomNavigation {
  @override
  int build() {
    return 0;
  }

  void changeSelectedIndex(int index) {
    state = index;
  }
}

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  static final _screen = [MemoPage(), CalendarPage(), DiaryPage()];
  static final _screenIcon = [
    Icons.edit_note,
    Icons.event,
    Icons.auto_stories,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedBottomNavigationProvider);
    return Scaffold(
      body: _screen[selectedIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: Colors.white,
        itemCount: _screenIcon.length,
        activeIndex: selectedIndex,
        gapLocation: GapLocation.none,
        splashColor: Colors.deepOrange,
        onTap: (int index) {
          ref
              .read(selectedBottomNavigationProvider.notifier)
              .changeSelectedIndex(index);
        },
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.deepOrange : Colors.black;
          return Icon(
            _screenIcon[index],
            size: 24,
            color: color,
          );
        },
      ),
    );
  }
}
