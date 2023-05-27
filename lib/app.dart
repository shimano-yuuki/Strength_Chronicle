import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/view/calendar_page.dart';
import 'package:workout_app/view/diary_page.dart';
import 'package:workout_app/view/memo_page.dart';


final _selectedIndexProvider = StateProvider((ref) => 0);


class BottomNavigation extends ConsumerWidget{
  const BottomNavigation({Key? key}) : super(key: key);



  static final _screen = [MemoPage(),CalenderPage(),DiaryPage()];
  static final _screenIcon = [Icons.edit_note,Icons.event,Icons.auto_stories,];

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    return Scaffold(
      body: _screen[ref.watch(_selectedIndexProvider)],
      bottomNavigationBar:AnimatedBottomNavigationBar.builder(
        backgroundColor: Colors.white,
          itemCount: _screenIcon.length,
          activeIndex: ref.watch(_selectedIndexProvider),
        gapLocation: GapLocation.none,
        splashColor: Colors.deepOrange,
          onTap: (int index){
            _screen[ref.read(_selectedIndexProvider.notifier).state = index];
          }, tabBuilder: (int index, bool isActive) {
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
