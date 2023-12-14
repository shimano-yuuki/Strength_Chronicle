import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workout_app/model/auth/firebase_auth.dart';
import 'package:workout_app/textstyle.dart';
import 'package:workout_app/view/calender/calendar_page.dart';
import 'package:workout_app/view/diary/diary_page.dart';
import 'package:workout_app/view/login_page.dart';
import 'package:workout_app/view/memo/memo_page.dart';

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
        splashColor: Colors.orange,
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

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ListTile listTileWidget(String title, int index) {
      return ListTile(
        title: Text(
          title,
          style: MyTextStyles.body.bold,
        ),
        onTap: () {
          final selectedIndex = ref.watch(selectedBottomNavigationProvider);
          if (selectedIndex == index) {
            Navigator.pop(context);
          } else {
            ref
                .read(selectedBottomNavigationProvider.notifier)
                .changeSelectedIndex(index);
          }
        },
      );
    }

    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () async{
              final service = AuthService();
              await service.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(
                    )),
              );
            },
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'ログアウト',
              style: MyTextStyles.body.bold,
            ),
          ),
          Divider(height: 1),
          listTileWidget('メモページ', 0),
          listTileWidget('カレンダー', 1),
          listTileWidget('日記', 2),
        ],
      ),
    );
  }
}
