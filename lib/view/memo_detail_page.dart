import 'package:flutter/material.dart';
import 'package:workout_app/model/memo_state.dart';

class MemoDetailPage extends StatelessWidget {
  const MemoDetailPage({Key? key, required this.memo}) : super(key: key);
  final Memo memo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            children: [
              /// メモの詳細情報を載せる(各々のデータを持ってくる) ///
              SizedBox(height: 24,),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Center(child: Text(memo.title,style: TextStyle(fontSize: 24),),),
                    Center(child: Text(memo.part,style: TextStyle(fontSize: 24),),),
                    Center(child: Text(memo.type,style: TextStyle(fontSize: 24),),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
