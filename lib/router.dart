
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workout_app/view/calender/calendar_page.dart';
import 'package:workout_app/view/diary/diary_page.dart';
import 'package:workout_app/view/login_page.dart';
import 'package:workout_app/view/memo/memo_page.dart';
import 'package:workout_app/view_model/signup_notifier.dart';
part 'router.g.dart';

class PagePath {
  static const signIn = '/sign-in';
  static const memo = '/memo';
  static const calender = '/calender';
  static const diary = '/diary';
}

@riverpod
GoRouter router(RouterRef ref) {
  final routes = [
    GoRoute(path: PagePath.signIn,
      builder: (_,__) => const LoginPage(),
    ),
    ShellRoute(builder: (_,__,child) => UserIdScope(child: child),
      routes: [
        GoRoute(path: PagePath.memo,
          builder: (_,__) => const MemoPage(),
        ),
        GoRoute(path: PagePath.calender,
          builder: (_,__) => const CalendarPage(),
        ),
        GoRoute(path: PagePath.diary,
          builder: (_,__) => const DiaryPage(),
        ),
      ]
    )
  ];

  String? redirect(BuildContext context, GoRouterState state) {
    final page = state.uri.toString();
    final signedIn = ref.read(signedInProvider);
    if (signedIn && page == PagePath.signIn) {
      return PagePath.memo;
    } else if (!signedIn) {
      return PagePath.signIn;
    } else {
      return null;
    }
  }

  final listenable = ValueNotifier<Object?>(null);
  ref.listen<Object?>(signedInProvider, (_, newState) {
    listenable.value = newState;
  });
  ref.onDispose(listenable.dispose);


  return GoRouter(
    initialLocation: PagePath.signIn,
    routes: routes,
    redirect: redirect,
    refreshListenable: listenable,
  );
}