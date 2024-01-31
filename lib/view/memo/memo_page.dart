import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/app.dart';
import 'package:workout_app/model/memo/memo_state.dart';
import 'package:workout_app/repository/auth/auth_repository_impl.dart';
import 'package:workout_app/textstyle.dart';
import 'package:workout_app/view/widget/bottom_sheet.dart';
import 'package:workout_app/view/widget/custom_alert_dialog.dart';
import 'package:workout_app/view/widget/dropdown_button.dart';
import 'package:workout_app/view/widget/tab.dart';
import 'package:workout_app/view/widget/text_form.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class MemoPage extends ConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBar = AppBar(
      title: Text(
        '種目メモ',
        style: MyTextStyles.title.bold,
      ),
      centerTitle: true,
      elevation: 5,
      bottom: TabBar(
        isScrollable: true,
        labelStyle: MyTextStyles.label.large.bold,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(text: '全て'),
          Tab(text: '胸'),
          Tab(text: '背中'),
          Tab(text: '腕'),
          Tab(text: '肩'),
          Tab(text: '脚'),
          Tab(text: '腹'),
        ],
      ),
    );
    final floatingActionButton = Stack(
      children: [
        DragTarget<Memo>(
          builder: (context, candidateData, rejectedData) {
            return Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            );
          },
          onAccept: (data) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) {
                return AlertDialog(
                  title: Text('確認'),
                  content: Text('本当に削除しますか？'),
                  actions: [
                    TextButton(
                      child: Text('キャンセル'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: Text('削除'),
                      onPressed: () {
                        ref.read(memosProvider.notifier).removeMemo(data.id);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            // ref.read(memosProvider.notifier).removeMemo(data.id);
          },
        ),
        Visibility(
          visible: ref.watch(visibleProvider),
          child: FloatingActionButton(
            onPressed: () {
              _showBottomSheetMenu(context,ref);
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
    final drawer = DrawerWidget();

    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
        appBar: appBar,
        body: TabBarView(
          children: [
            CommonTabViewWidget(),
            CommonTabViewWidget(part: '胸'),
            CommonTabViewWidget(part: '背中'),
            CommonTabViewWidget(part: '腕'),
            CommonTabViewWidget(part: '肩'),
            CommonTabViewWidget(part: '脚'),
            CommonTabViewWidget(part: '腹'),
          ],
        ),
        floatingActionButton: floatingActionButton,
        drawer: drawer,
      ),
    );
  }

  void _showBottomSheetMenu(BuildContext context, WidgetRef ref) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    final trainingNameController = TextEditingController();

    String? id = "11111";
    String title = trainingNameController.text;
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

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (_) {
        return BottomSheetWidget();
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
      },
    );
  }
}
