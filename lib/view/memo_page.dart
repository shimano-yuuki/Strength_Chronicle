import 'package:flutter/material.dart';

class MemoPage extends StatelessWidget {
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                const SizedBox(height: 24,),
                /// ------------  部位選択  -------------///
                DropdownButtonWidget(text: '部位を選択',),
                const SizedBox(height: 24,),
                DropdownButtonWidget(text: 'トレーニング種類',),
                /// ------------------------ ///
                const Center(
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: SafeArea(
        child: Scaffold(
          appBar: const TabBar(
            // isScrollable: true,
              tabs: [
                Tab(text: '全て',),
                Tab(text: '胸',),
                Tab(text: '背',),
                Tab(text: '腕',),
                Tab(text: '肩',),
                Tab(text: '脚',),
                Tab(text: '腹',),
              ],
          ),
          // appBar: AppBar(),
          body: const TabBarView(
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
    return Column(
        children: [
          SizedBox(
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
        ],
      );
  }
}

class DropdownButtonWidget extends StatelessWidget {
  const DropdownButtonWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width:  10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
              ),
              SizedBox(width: 8,),
              Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ],
          ),
          DropdownButton(
            hint: Text('選択してください'),
            items: [
              DropdownMenuItem(
                child: Text('胸'),
                value: '胸',
              ),
              DropdownMenuItem(
                child: Text('背中'),
                value: '背中',
              ),
              DropdownMenuItem(
                child: Text('肩'),
                value: '肩',
              ),
            ], onChanged: (String? value) {  },),
        ],
      ),
    );
  }
}
