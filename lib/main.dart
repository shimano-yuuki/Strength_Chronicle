import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/app.dart';
import 'package:workout_app/view/memo_page.dart';

void main() {
  const app = MyApp();
  const scope = ProviderScope(child: app);
  runApp(scope);
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