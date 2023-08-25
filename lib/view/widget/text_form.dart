import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_app/view_model/Login_notifier.dart';

class TextFormWidget extends ConsumerWidget {
  const TextFormWidget({
    super.key,
    this.keyboardType,
    required this.icon,
    required this.labelText,
    this.obscure = false,
  });

  final TextInputType? keyboardType;
  final String labelText;
  final Icon icon;
  final bool obscure;

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
      obscureText: obscure == false ? false : ref.watch(isObscureProvider),
      keyboardType: keyboardType,
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          prefixIcon: icon,
          suffixIcon: suffixIcon),
    );
  }
}
