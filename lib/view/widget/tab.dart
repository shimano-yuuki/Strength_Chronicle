import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/model/memo/memo_state.dart';
import 'package:workout_app/view/widget/memo_card.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class TabViewWidget extends ConsumerWidget {
  const TabViewWidget({Key? key, this.part}) : super(key: key);

  final String? part;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Memo> memos = ref.watch(memosProvider);
    return ListView.builder(
      itemCount: memos.length,
      itemBuilder: (BuildContext context, int index) {
        if (part == null || memos[index].part == part) {
          return Draggable<Memo>(
            onDragStarted: (){
              ref.read(visibleProvider.notifier).changeVisible(false);
            },
            onDragEnd: (DraggableDetails details) {
              ref.read(visibleProvider.notifier).changeVisible(true);
            },
            data: memos[index],
            feedback: Material(
              child: MemoCardWidget(
                memo: memos[index],
              ),
            ),
            childWhenDragging: Container(),
            child: MemoCardWidget(
              memo: memos[index],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}





