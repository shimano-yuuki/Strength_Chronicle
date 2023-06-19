import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/view/memo_detail_page.dart';

class MemoPage extends ConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);


  void  _showBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder) {
          return Container(
            height: 600.0,
            color: Colors.transparent,
            child: Column(
              children: [
                const SizedBox(height: 24,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.cancel,color: Colors.grey,),
                    Text('種目を追加',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    Text('追加',style: TextStyle(color: Colors.orange),)
                  ],
                ),
                const SizedBox(height: 16,),
                Divider(
                ),
                const SizedBox(height: 24,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),

                        hintText: '種目名を入力してください',
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text('トレーニング種類',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

                        ],
                      ),
                      SizedBox(
                        width: 300,
                          height: 300,
                          child: DropdownButton(
                            // value: ,
                              items: ['胸','背中','腕','肩','脚','腹',]
                                  .map((String list) =>
                                  DropdownMenuItem(value: list, child: Text(list)))
                                  .toList(),
                              onChanged: (String? value){})
                          ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
              Center(
                child: Column(
                  children: [
                    Text('種目',style: TextStyle(fontSize: 24),),
                    MemoCardWidget(title: 'アームカール', color: Colors.redAccent),
                    MemoCardWidget(title: 'ハンマーカール', color: Colors.blueAccent),
                    MemoCardWidget(title: 'レッグレイズ', color: Colors.orangeAccent),
                    MemoCardWidget(title: 'インクラインロウ', color: Colors.greenAccent),
                    MemoCardWidget(title: 'ベンチプレス', color: Colors.black),
                    MemoCardWidget(title: 'ダンベルフライ', color: Colors.yellowAccent),
                    MemoCardWidget(title: 'ディップス', color: Colors.pinkAccent),
                  ],
                ),
              ),
              Center(child: Text('胸')),
              Center(child: Text('背中')),
              Center(child: Text('腕')),
              Center(child: Text('肩')),
              Center(child: Text('脚')),
              Center(child: Text('腹')),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              _showBottomSheetMenu(context);
            },
            child: const Icon(Icons.add,color: Colors.white,),
          ),
        ),
      ),
    );
  }
}

class MemoCardWidget extends StatelessWidget {
  const MemoCardWidget({Key? key, required this.title, required this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: 300,
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
                  color: color),
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

