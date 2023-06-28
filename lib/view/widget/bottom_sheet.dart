import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/model/memo_state.dart';
import 'package:workout_app/view/widget/dropdown_button.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class BottomSheetWidget extends ConsumerWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? id =  "11111";
    String title = ref.watch(textFromFieldProvider);
    String part = ref.watch(dropDownButtonProvider);
    String? type = "自重";
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
                final memo = Memo(id: id, title: title, part: part, type: type);
                // print('id:$id');
                // print('タイトル:$title');
                // print('部位:$part');
                // print('トレーニング種類:$type');
                print(memo);
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
                ref.read(textFromFieldProvider.notifier).changeText(text);
                print(ref.watch(textFromFieldProvider));
                print(part);
                print(type);
                print(id);
              },
              autofocus: true,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: '種目名を入力してください',
                  border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 24,),
          Expanded(
            child: SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    DropdownWidget(['胸','背中','腕','肩','脚','腹',], '部位'),
                    SizedBox(height: 24,),
                    // DropdownWidget(['自重','フリーウェイト','マシン'], 'トレーニング種類')
                    // DropdownWidget(['胸','背中','腕','肩','脚','腹',], '部位'),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
