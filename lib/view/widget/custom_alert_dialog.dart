import 'package:flutter/material.dart';
import 'package:workout_app/textstyle.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.contentWidget,
    required this.defaultActionText,
    this.action,
  }) : super(key: key);

  final String title;
  final Widget contentWidget;
  final String defaultActionText;
  final Function? action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: EdgeInsets.all(24),
      actionsPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      title: Center(
          child: Text(
        title,
        style: MyTextStyles.title.bold,
      )),
      content: contentWidget,
      actions: [
        Center(
          child: Container(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
                onPressed: () {
                  if (action != null) action!();
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  defaultActionText,
                  style: MyTextStyles.body.bold.white,
                )),
          ),
        )
      ],
    );
  }
}
