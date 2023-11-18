import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/view_model/Login_notifier.dart';

class TextFormWidget extends ConsumerWidget {
  const TextFormWidget( {
    super.key,
    this.keyboardType,
    required this.icon,
    required this.labelText,
    this.obscure = false,
    this.onChanged,
    this.controller,
    this.validateText,
  });

  final TextInputType? keyboardType;
  final String labelText;
  final Icon icon;
  final bool obscure;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validateText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget? suffixIcon;
    if (obscure == true) {
      suffixIcon = IconButton(
          icon: Icon(ref.watch(isObscureProvider)
              ? Icons.visibility_off
              : Icons.visibility),
          onPressed: () {
            ref.read(isObscureProvider.notifier).changeIsObscure();
          });
    } else {
      suffixIcon = null;
    }

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscure == false ? false : ref.watch(isObscureProvider),
      keyboardType: keyboardType,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: icon,
          suffixIcon: suffixIcon),
      validator: validateText,
    );
  }
}

class ValidateText {
  static ValidateText validate = ValidateText();
  static String? email(String? value) {
    if(value != null){
      String pattern = r'^[0-9a-z_./?-]+@([0-9a-z-]+\.)+[0-9a-z-]+$';
      RegExp regExp = RegExp(pattern);
      if(!regExp.hasMatch(value)){
        return '正しいメールアドレスを入力してください';
      }
    }
    return null;
  }

  static String? password(String? value) {
    if(value != null){
      const pattern = r'^[a-zA-Z0-9]{10,}$';
      final regExp = RegExp(pattern);
      if(!regExp.hasMatch(value)){
        return '10文字以上の英数字を入力してください';
      }
    }
    return null;
  }
}