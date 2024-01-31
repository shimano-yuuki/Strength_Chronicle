import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workout_app/model/auth/firebase_auth.dart';
import 'package:workout_app/model/auth/firebase_auth_error.dart';
import 'package:workout_app/repository/auth/auth_repository_impl.dart';
import 'package:workout_app/repository/memo_repository_impl.dart';
import 'package:workout_app/textstyle.dart';
import 'package:workout_app/validate.dart';
import 'package:workout_app/view/signup_page.dart';
import 'package:workout_app/view/widget/custom_alert_dialog.dart';
import 'package:workout_app/view/widget/text_form.dart';
import 'package:workout_app/view_model/memo_notifier.dart';

import '../app.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    void _showErrorDialog(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomAlertDialog(
            title: 'エラー',
            contentWidget: Text(message),
            defaultActionText: 'OK',
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: bottomSpace,
              ),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: MyTextStyles.title.large.bold,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Google ログイン ///
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final service = AuthService();
                              await service.signInWithGoogle(context);
                            },
                            child:  const LoginIconWidget(
                              logoId: 'assets/images/google-logo.svg',
                            ),
                          ),
                        ),

                        /// X ログイン　///
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: const LoginIconWidget(
                              logoId: 'assets/images/x-logo.svg',
                            ),
                          ),
                        ),

                        /// APPlE ログイン ///
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: const LoginIconWidget(
                              logoId: 'assets/images/apple-logo.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'または',
                            style: MyTextStyles.label,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    CustomTextFormWidget(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      icon: const Icon(Icons.mail),
                      labelText: 'メールアドレス',
                      validateText: ValidateText.email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormWidget(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      icon: const Icon(Icons.lock),
                      labelText: 'パスワード',
                      obscure: true,
                      validateText: ValidateText.password,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'パスワードをお忘れのかた',
                        style: MyTextStyles.label.blue,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),

                    /// メール&パスワード ログイン ///
                    InkWell(
                      onTap: () async {
                        AuthRepositoryImpl authRepository =
                        AuthRepositoryImpl();
                        try {
                          await authRepository.signIn(
                              email: emailController.text,
                              password: passwordController.text);
                          debugPrint("ユーザーがログインしました。");
                          debugPrint("email:${emailController.text}");
                          debugPrint("password:${passwordController.text}");
                          ref.read(memosProvider.notifier).state = await MemoRepositoryImpl().fetchMemo();
                          print(ref.read(memosProvider));
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const BottomNavigation()));
                        } on FirebaseAuthException catch (e) {
                          var message =
                              FirebaseAuthErrorExt
                                  .fromCode(e.code)
                                  .message;
                          _showErrorDialog(context, message);
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'ログイン',
                            style: MyTextStyles.body.bold.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'アカウントをお持ちでない方は',
                          style: MyTextStyles.label,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            'こちら',
                            style: MyTextStyles.label.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginIconWidget extends StatelessWidget {
  const LoginIconWidget({
    super.key,
    required this.logoId,
  });

  final String logoId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(1, 1),
          )
        ],
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SvgPicture.asset(
          logoId,
          fit: BoxFit.contain,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}
