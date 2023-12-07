import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_app/model/memo/memo_state.dart';
import 'package:workout_app/textstyle.dart';
import 'package:workout_app/view/widget/custom_alert_dialog.dart';
import 'package:workout_app/view/widget/dropdown_button.dart';
import 'package:workout_app/view/widget/text_form.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class BottomSheetWidget extends ConsumerWidget {
  BottomSheetWidget({Key? key}) : super(key: key);
  final trainingNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    String? id = Uuid().v4();
    String title = ref.watch(textFromFieldProvider);
    String? part = ref.watch(dropDownButtonProvider).part;
    String? type = ref.watch(dropDownButtonProvider).type;

    void _showErrorDialog(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomAlertDialog(
            title: 'エラー',
            contentWidget: Text(message),
            defaultActionText: 'OK',
          );
        },
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: bottomSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.grey,
                      )),
                  Text(
                    '種目を追加',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      /// ここに内容が記載されてるかの処理 ///
                      title = trainingNameController.text;
                      debugPrint("$id,$title,$part,$type");
                      if (title.isEmpty) {
                        final message = '種目名を入力してください。';
                        _showErrorDialog(context, message);
                      } else if (part.isEmpty) {
                        final message = '部位を選択してください。';
                        _showErrorDialog(context, message);
                      } else if (type.isEmpty) {
                        final message = 'トレーニングの種類を選択してください。';
                        _showErrorDialog(context, message);
                      } else {
                        final memo =
                            Memo(id: id, title: title, part: part, type: type);
                        ref.watch(memosProvider.notifier).addMemo(memo);
                        debugPrint('メモを追加しました');
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('追加', style: TextStyle(color: Colors.orange)),
                  )
                ],
              ),
            ),
            Divider(
              /// height:0を指定しないと余白が発生する ///
              height: 0,
              color: MyColors.grey,
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  CustomTextFormWidget(
                    keyboardType: TextInputType.text,
                    labelText: '種目名',
                    controller: trainingNameController,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
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
                          DropdownWidget(['自重', 'フリーウェイト', 'マシン'],
                              DropButtonType.trainingType),
                          // Container(
                          //     width: double.infinity,
                          //     child: ElevatedButton(
                          //         onPressed: () {},
                          //         child: Text(
                          //           'send',
                          //           style: MyTextStyles.body.white,
                          //         )))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ElevatedButton(onPressed: (){}, child: Text('種目を追加',style,))
          ],
        ),
      ),
    );
    ;
  }
}
