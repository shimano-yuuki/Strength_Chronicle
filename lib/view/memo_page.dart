import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/model/memo_state.dart';
import 'package:workout_app/view/memo_detail_page.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class MemoPage extends ConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);


  void  _showBottomSheetMenu(BuildContext context,WidgetRef ref) {

    String? id = "059rioi";
    String? title;
    String? part;
    String? type = "自重";



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
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.cancel,color: Colors.grey,),
                    Text('種目を追加',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    TextButton(onPressed: (){
                      final memo = Memo(id: id!, title: title!, part: part!, type: type!);
                      print('id:$id');
                      print('タイトル:$title');
                      print('部位:$part');
                      print('トレーニング種類:$type');
                      ref.watch(memosProvider.notifier).addMemo(memo);
                      Navigator.of(context).pop();
                    }, child: Text('追加',style: TextStyle(color: Colors.orange)),)
                  ],
                ),
                const SizedBox(height: 16,),
                Divider(
                ),
                const SizedBox(height: 24,),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    onChanged: (String text){
                      ref.watch(textFromFieldProvider.notifier).changeText(text);
                      title = ref.read(textFromFieldProvider);
                    },
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
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
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
                            Text('部位',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

                          ],
                        ),
                        SizedBox(
                          width: 300,
                            // height: 300,
                            child: DropdownButton(
                              value: part,
                              hint: Text('選択してください'),
                                items: ['胸','背中','腕','肩','脚','腹',]
                                    .map((String list) =>
                                    DropdownMenuItem(value: list, child: Text(list)))
                                    .toList(),
                                onChanged: (String? value){
                                  part = value;
                                })
                            ),
                        SizedBox(height: 24,),
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
                            // height: 300,
                            child: DropdownButton(
                                value: part,
                                hint: Text('選択してください'),
                                items: ['胸','背中','腕','肩','脚','腹',]
                                    .map((String list) =>
                                    DropdownMenuItem(value: list, child: Text(list)))
                                    .toList(),
                                onChanged: (String? value){
                                  part = value;
                                })
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
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
              Center(
                child: Column(
                  children: [
                    Text('種目',style: TextStyle(fontSize: 24),),
                    Expanded(
                      child: ListView.builder(
                        itemCount: memos.length,
                          itemBuilder: (BuildContext context, int index){
                          return MemoCardWidget(title: memos[index].title, part: memos[index].part,);
                          }
                      ),
                    ),
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

