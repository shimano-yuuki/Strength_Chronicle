import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/view/memo_detail_page.dart';

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