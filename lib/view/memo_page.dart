import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/model/memo_state.dart';
import 'package:workout_app/view/widget/bottom_sheet.dart';
import 'package:workout_app/view/widget/tab.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class MemoPage extends ConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '種目名',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                ref.read(visibleProvider.notifier).changeVisible(false);
              },
            ),
          ],
          centerTitle: true,
          elevation: 5,
          bottom: TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: '全て'),
              Tab(text: '胸'),
              Tab(text: '背中'),
              Tab(text: '腕'),
              Tab(text: '肩'),
              Tab(text: '脚'),
              Tab(text: '腹'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TabViewWidget(),
            TabViewWidget(part: '胸'),
            TabViewWidget(part: '背中'),
            TabViewWidget(part: '腕'),
            TabViewWidget(part: '肩'),
            TabViewWidget(part: '脚'),
            TabViewWidget(part: '腹'),
          ],
        ),
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: DragTarget<Memo>(
                builder: (context, candidateData, rejectedData) {
                  return GestureDetector(
                    onTap: () {
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: true,
                      //   builder: (_) {
                      //     return AlertDialog(
                      //       title: Text('確認'),
                      //       content: Text('本当に削除しますか？'),
                      //       actions: <Widget>[
                      //         TextButton(
                      //           child: Text('キャンセル'),
                      //           onPressed: () => Navigator.of(context).pop(),
                      //         ),
                      //         TextButton(
                      //           child: Text('削除'),
                      //           onPressed: () {
                      //             ref.read(memosProvider.notifier).removeMemo(data.id);
                      //             Navigator.of(context).pop();
                      //           },
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
                    },
                    child: Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(0, 2),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                onAccept: (data) {
                  ref.read(memosProvider.notifier).removeMemo(data.id);
                },
              ),
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: Visibility(
                visible: ref.watch(visibleProvider),
                child: FloatingActionButton(
                  onPressed: () {
                    _showBottomSheetMenu(context, ref);
                  },
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  'メモページ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'カレンダー',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  '日記',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheetMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (builder) {
        return const BottomSheetWidget();
      },
    );
  }
}
