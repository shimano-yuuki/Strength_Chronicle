import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/view/diary_add_page.dart';

import '../app.dart';

class DiaryPage extends ConsumerWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '日記',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      drawer: DrawerWidget(),
      body: Container(),
      floatingActionButton:
      FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DiaryAddPage(
                )),
          );
          // Add your onPressed code here!
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
