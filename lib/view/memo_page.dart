import 'package:flutter/material.dart';

class MemoPage extends StatelessWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('種目',style: TextStyle(fontSize: 24),),
            MemoCardWidget(title: 'アームカール', color: Colors.deepOrange)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
}

class MemoCardWidget extends StatelessWidget {
  const MemoCardWidget({Key? key, required this.title, required this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(
            width: 300,
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
                      color: color),
                    ),
                  Expanded(child: Container()),
                  Text(title),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ],
      );
  }
}

