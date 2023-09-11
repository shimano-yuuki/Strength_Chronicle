import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workout_app/app.dart';
import 'package:workout_app/view/login_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        fontFamily: 'Noto_Sans_JP',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white
        )
      ),
      home: LoginPage(),
    );
  }
}