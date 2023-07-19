import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

enum DropButtonType {
  part(name: '部位'),
  trainingType(name: 'トレーニング種類');

  const DropButtonType({required this.name});

  final String name;
}

class DropdownWidget extends ConsumerWidget {
  const DropdownWidget(this.items, this.type, {super.key});

  final List<String> items;
  final DropButtonType type;

  String typeChecked(WidgetRef ref) {
    switch (type) {
      case DropButtonType.part:
        return ref.watch(dropDownButtonProvider).part;
      case DropButtonType.trainingType:
        return ref.watch(dropDownButtonProvider).type;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? value = type == DropButtonType.part
        ? ref.watch(dropDownButtonProvider).part
        : ref.watch(dropDownButtonProvider).type;

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
                    color: Colors.orange, shape: BoxShape.circle),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                type.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          DropdownButton(
            value: value != '' ? value : null,
            hint: const Text('選択してください'),
            items: items
                .map((String list) =>
                    DropdownMenuItem(value: list, child: Text(list)))
                .toList(),
            onChanged: (String? newValue) {
              switch (type) {
                case DropButtonType.part:
                  return ref
                      .read(dropDownButtonProvider.notifier)
                      .selected(part: newValue);
                case DropButtonType.trainingType:
                  return ref
                      .read(dropDownButtonProvider.notifier)
                      .selected(type: newValue);
              }
            },
            isExpanded: true,
          ),
        ],
      ),
    );
  }
}
