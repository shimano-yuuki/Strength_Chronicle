import 'package:flutter/material.dart';

class MemoDetailPage extends StatelessWidget {
  const MemoDetailPage({Key? key}) : super(key: key);

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
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all()
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
