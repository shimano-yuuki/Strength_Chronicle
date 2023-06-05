import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatelessWidget {
  const DropdownButtonWidget({Key? key, required this.text, required this.menuItem}) : super(key: key);

  final String text;
  final List menuItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width:  10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
              ),
              SizedBox(width: 8,),
              Text('text',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ],
          ),
          DropdownButton(
            hint: Text('選択してください'),
            items: [
              DropdownMenuItem(
                child: Text('胸'),
                value: '胸',
              ),
              DropdownMenuItem(
                child: Text('背中'),
                value: '背中',
              ),
              DropdownMenuItem(
                child: Text('肩'),
                value: '肩',
              ),
            ], onChanged: (String? value) {  },),
        ],
      ),
    );
  }
}
