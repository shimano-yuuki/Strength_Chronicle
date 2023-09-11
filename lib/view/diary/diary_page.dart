import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/textstyle.dart';
import 'package:workout_app/view/diary/diary_add_page.dart';

import '../../app.dart';
import '../../view_model/diary_provider.dart';

class DiaryPage extends ConsumerWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  diaries = ref.watch(diaryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '日記',
          style: MyTextStyles.title.bold,
        ),
        centerTitle: true,
        elevation: 5,
      ),
      drawer: DrawerWidget(),
      body:diaries.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (diaries) {
          ListView.builder(
            itemCount: diaries.length,
            itemBuilder: (BuildContext context, int index) {
              final diary = diaries[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Row(children: [
                    SizedBox(width: 10),
                    Text(diary.createdAt as String,style: MyTextStyles.body),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(children: [
                      SizedBox(
                        height: 30,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 0,
                        ),
                        child: Expanded(
                          child: Center(
                            child: Text(
                              diary.chronicleContents,
                              style: MyTextStyles.body,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
                  ),
                ],
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString()),), //個人的には「再読み込み」のボタンを表示してref.refreshさせることが多いです。
      ),

      floatingActionButton:
      FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DiaryAddPage(
                )),
          );
          // Add your onPressed code here!
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
