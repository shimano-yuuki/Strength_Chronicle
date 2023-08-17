import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/textstyle.dart';
import 'package:workout_app/view/diary_add_page.dart';

import '../app.dart';

class DiaryPage extends ConsumerWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MapEntry<String, String>> contents = [
      MapEntry("2023年8月20日", "今日はスクワットとデッドリフトの日。きついトレーニングだけど、体全体を鍛えられるから重要だ。各セットごとに形を意識し、筋肉とコミュニケーションを取る。今日は新しいパーソナルベストを出せたので、とても達成感があった。"),
      MapEntry("2023年8月19日", "今日のトレーニングは上半身。ベンチプレスとプルアップをメインに行った。プルアップは自分の体重を持ち上げるだけでも十分なトレーニングになる。ちょっとずつだけど、前よりも多くリフトできるようになってきて、嬉しい限りだ。"),
      MapEntry("2023年8月17日", "筋肉痛が強くて起きるのが大変だった。しかし、これも成長の証だからと自分に言い聞かせた。休養日なので、プロテインスムージーを飲みながら好きな映画を観た。筋肉の回復とリラクゼーションのための大切な一日だった。"),
      MapEntry("2023年8月17日", "今日のトレーニングはレッグデイ。スクワットとルンゲを行った。脚の筋肉は大きいからエネルギー消費も大きい。トレーニング後の食事が特に美味しい。自分の体を鍛える努力が、食べ物の味を一層引き立てるようだ。"),

    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '日記',
          style: MyTextStyles.title.large.bold,
        ),
        centerTitle: true,
        elevation: 5,
      ),
      drawer: DrawerWidget(),
      body:  ListView.builder(
        itemCount: contents.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(children: [
                SizedBox(width: 10),
                Text(contents[index].key,style: MyTextStyles.body),
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
                            contents[index].value,
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
