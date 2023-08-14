import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryAddPage extends ConsumerWidget {
  const DiaryAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
        '日記を追加する',
        style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),);
  }
}
