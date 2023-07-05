import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/model/memo_state.dart';
import 'package:workout_app/view/memo_detail_page.dart';

class MemoCardWidget extends ConsumerWidget {

  final Memo memo;

  const MemoCardWidget({
    required this.memo,
    Key? key,
  }) : super(key: key);


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
    String title = memo.title;
    String part =memo.part;
    return Center(
      child: SizedBox(
        width: 350,
        height: 65,
        child: InkWell(
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
                  Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Expanded(child: Container()),

                ],
              ),
            ),
            onTap: (){
              /// メモのデータ ///
              /// 画面遷移 ///
              Navigator.push(context, MaterialPageRoute(builder: (context) => MemoDetailPage(memo: memo,)));
            }
        ),
      ),
    );
  }
}