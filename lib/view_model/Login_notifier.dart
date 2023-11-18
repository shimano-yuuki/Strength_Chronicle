import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'Login_notifier.g.dart';

@riverpod
class IsObscure extends _$IsObscure {
  @override
  bool build() {
    return false;
  }

  void changeIsObscure() {
    state = !state;
  }
}

@riverpod
class EmailController extends _$EmailController {
  @override
  String build() {
    return "";
  }
}

@riverpod
class PasswordController extends _$PasswordController {
  @override
  String build() {
    return "";
  }
}

@riverpod
class Validator extends _$Validator {
  @override
  String? Function(String?)? build() {
    return null;
  }
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
