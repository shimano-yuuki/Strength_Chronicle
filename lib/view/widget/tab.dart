import 'package:flutter/material.dart';
import 'package:workout_app/model/memo_state.dart';
import 'package:workout_app/view/memo_page.dart';

class TabViewWidget extends StatelessWidget {
  const TabViewWidget({super.key, required this.memos, this.part});

  final List<Memo> memos;
  final String? part;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (part != null)
          Text(
            part!,
            style: TextStyle(fontSize: 24),
          )
        else
          Text(
            '全て',
            style: TextStyle(fontSize: 24),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: memos.length,
            itemBuilder: (BuildContext context, int index) {
              if (part == null || memos[index].part == part) {
                return MemoCardWidget(
                  title: memos[index].title,
                  part: memos[index].part,
                );
              } else {
                return SizedBox(); // 非表示にする
              }
            },
          ),
        ),
      ],
    );
  }
}