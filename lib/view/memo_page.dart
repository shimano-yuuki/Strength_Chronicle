import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/model/memo_state.dart';
import 'package:workout_app/view/memo_detail_page.dart';
import 'package:workout_app/view/widget/bottom_sheet.dart';
import 'package:workout_app/view/widget/tab.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class MemoPage extends ConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);


  void  _showBottomSheetMenu(BuildContext context,WidgetRef ref) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder) {
          return BottomSheetWidget();
        });
  }



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
}

class MemoCardWidget extends ConsumerWidget {
  const MemoCardWidget({Key? key, required this.title, required this.part}) : super(key: key);

  final String title;
  final String part;


  colorChange(String part){
    switch(part){
      case '胸':
        return Colors.red;
      case '背中':
        return Colors.blue;
      case '腕':
        return Colors.yellow;
      case '肩':
        return Colors.green;
      case '脚':
        return Colors.orange;
      case '腹':
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: SizedBox(
        height: 50,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10,),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorChange(part)),
                ),
              Expanded(child: Container()),
              Text(title),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
      onTap: (){
        /// メモのデータ ///
        /// 画面遷移 ///
        Navigator.push(context, MaterialPageRoute(builder: (context) => MemoDetailPage()));
      }
    );
  }
}