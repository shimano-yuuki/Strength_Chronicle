import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/model/memo_state.dart';
import 'package:workout_app/view/memo_detail_page.dart';
import 'package:workout_app/view/widget/bottom_sheet.dart';
import 'package:workout_app/view/widget/tab.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class MemoPage extends ConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Memo> memos = ref.watch(memosProvider);
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: SafeArea(
        child: Scaffold(
          appBar: TabBar(
            // isScrollable: true,
              tabs: [
                Tab(text: '全て',),
                Tab(text: '胸',),
                Tab(text: '背中',),
                Tab(text: '腕',),
                Tab(text: '肩',),
                Tab(text: '脚',),
                Tab(text: '腹',),
              ],
          ),
          // appBar: AppBar(),
          body:  TabBarView(
            children: [
              TabViewWidget(memos: memos),
              TabViewWidget(memos: memos, part: '胸'),
              TabViewWidget(memos: memos, part: '背中'),
              TabViewWidget(memos: memos, part: '腕'),
              TabViewWidget(memos: memos, part: '肩'),
              TabViewWidget(memos: memos, part: '脚'),
              TabViewWidget(memos: memos, part: '腹'),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              _showBottomSheetMenu(context,ref);
            },
            child: const Icon(Icons.add,color: Colors.white,),
          ),
        ),
      ),
    );
  }
  void  _showBottomSheetMenu(BuildContext context,WidgetRef ref) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder) {
          return const BottomSheetWidget();
        });
  }
}

