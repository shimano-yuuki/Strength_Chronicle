import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workout_app/app.dart';


void main() {
  const app = MyApp();
  const scope = ProviderScope(child: app);
   /// 下の記述でカレンダーを日本語かさせる　///
  initializeDateFormatting('ja').then((_) =>
      runApp(scope));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StrengthChronicle',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: BottomNavigation(),
    );
  }
}