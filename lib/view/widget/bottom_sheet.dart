import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_app/model/memo/memo_state.dart';
import 'package:workout_app/view/widget/dropdown_button.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class BottomSheetWidget extends ConsumerWidget {
  BottomSheetWidget({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? id = Uuid().v4();
    String title = ref.watch(textFromFieldProvider);
    String part = ref.watch(dropDownButtonProvider).part;
    String? type = ref.watch(dropDownButtonProvider).type;
    return Container(
      height: 600.0,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: Icon(Icons.cancel,color: Colors.grey,)),
              Text(
                '種目を追加',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final memo =
                        Memo(id: id, title: title, part: part, type: type);
                    ref.watch(memosProvider.notifier).addMemo(memo);
                    Navigator.of(context).pop();
                  } else {
                    ref.read(textFromFieldProvider.notifier).clearText();
                  }
                },
                child: Text('追加', style: TextStyle(color: Colors.orange)),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Divider(),
          const SizedBox(
            height: 24,
          ),
          Form(
            key: formKey,
            child: SizedBox(
              width: 300,
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '種目名が入力されていません。';
                  }
                },
                onChanged: (String text) {
                  ref.read(textFromFieldProvider.notifier).changeText(text);
                },
                autofocus: true,
                maxLength: 20,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '種目名',
                    border: OutlineInputBorder()),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          const Expanded(
            child: SizedBox(
              width: 350,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    DropdownWidget([
                      '胸',
                      '背中',
                      '腕',
                      '肩',
                      '脚',
                      '腹',
                    ], DropButtonType.part),
                    SizedBox(
                      height: 24,
                    ),
                    DropdownWidget(
                        ['自重', 'フリーウェイト', 'マシン'], DropButtonType.trainingType)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
