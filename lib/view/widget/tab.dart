import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/model/memo_state.dart';
import 'package:workout_app/view/widget/memo_card.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class TabViewWidget extends ConsumerWidget {
  const TabViewWidget({super.key, this.part});

  final String? part;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<Memo> memos = ref.watch(memosProvider);
    return ListView.builder(
      itemCount: memos.length,
      itemBuilder: (BuildContext context, int index) {
        if (part == null || memos[index].part == part) {
          return MemoCardWidget(
            memo:memos[index],
          );
        } else {
          return SizedBox(); // 非表示にする
        }
      },
    );
  }
}