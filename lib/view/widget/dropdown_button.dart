import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

class DropdownWidget extends ConsumerWidget {
  const DropdownWidget(this.items, this.name, {super.key});

  final List<String>  items;
  final String name;
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    String? value = ref.watch(dropDownButtonProvider);
    return Container(
      height: 100,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle
                ),
              ),
              const SizedBox(width: 10,),
              Text(name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ],
          ),
          DropdownButton(
              value: value != '' ? value : null,
              hint: const Text('選択してください'),
              items: items
                  .map((String list) =>
                  DropdownMenuItem(value: list, child: Text(list)))
                  .toList(),
              onChanged: (String? newValue){
                ref.watch(dropDownButtonProvider.notifier).selectedPart(newValue);
              },
            isExpanded: true,
            ),
        ],
      ),
    );
  }
}
