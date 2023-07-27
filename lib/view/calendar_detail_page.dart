import 'package:flutter/material.dart';

class CalendarDetailPage extends StatelessWidget {
  CalendarDetailPage({Key? key, required this.CalendarContant})
      : super(key: key);
  final String CalendarContant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.all(50),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '11:20',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                CalendarContant,
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
        )
      ]),
    );
  }
}
