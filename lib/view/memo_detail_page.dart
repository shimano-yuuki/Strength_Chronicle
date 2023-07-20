import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/app.dart';
import 'package:workout_app/model/memo_state.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class MemoDetailPage extends ConsumerWidget {
  const MemoDetailPage({Key? key, required this.memo}) : super(key: key);

  final Memo memo;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            ref.watch(memosProvider).remove(memo);
            }, icon: Icon(Icons.delete_forever_outlined),)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24,),
              Text('種目名',style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.bold),),
              Text(memo.title,style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Text('部位',style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.bold),),
              Text(memo.part,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Text('トレーニング種類',style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.bold),),
              Text(memo.type,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}
