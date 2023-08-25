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
