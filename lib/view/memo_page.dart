import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/view/widget/bottom_sheet.dart';
import 'package:workout_app/view/widget/tab.dart';

class MemoPage extends ConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text('種目名',style: TextStyle(fontWeight: FontWeight.bold),),
          actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),],
          centerTitle: true,
          elevation: 5,
          bottom: TabBar(
            // isScrollable: true,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
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
        ),
        // appBar: AppBar(),
        body:  TabBarView(
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _showBottomSheetMenu(context,ref);
          },
          child: const Icon(Icons.add,color: Colors.white,),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text('メモページ'),
                onTap: (){
                  Navigator.pop(context);

                },
              ),
              ListTile(
                title: Text('カレンダー'),
                onTap: (){
                  Navigator.pop(context);

                },
              ),
              ListTile(
                title: Text('日記'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ],
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


