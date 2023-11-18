import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workout_app/firebase_auth_error.dart';
import 'package:workout_app/service.dart';
import 'package:workout_app/textstyle.dart';
import 'package:workout_app/view/signup_page.dart';
import 'package:workout_app/view/widget/custom_alert_dialog.dart';
import 'package:workout_app/view/widget/text_form.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
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
                              await service.signInWithGoogle();
                              // await Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const BottomNavigation()));
                            },
                            child: const LoginIconWidget(
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
                    TextFormWidget(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      icon: const Icon(Icons.mail),
                      labelText: 'メールアドレス',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormWidget(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      icon: const Icon(Icons.lock),
                      labelText: 'パスワード',
                      obscure: true,
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
                        final service = AuthService();
                        try {
                          await service.signInWithEmailAndPassword(
                              emailController.text, passwordController.text);
                          debugPrint(emailController.text);
                          debugPrint(passwordController.text);
                        } on FirebaseAuthException catch (e) {
                          var message =
                              FirebaseAuthErrorExt.fromCode(e.code).message;
                          _showErrorDialog(context, message);
                        }
                        //
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const BottomNavigation()));
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

                    /// Alertダイアログをサンプルで表示 ///
                    // ElevatedButton(
                    //     onPressed: () {
                    //       showDialog(
                    //         context: context,
                    //         builder: (_) => CustomAlertDialog(
                    //           title: 'エラー',
                    //           contentWidget: Text(
                    //             'メールアドレスまたはパスワードが違います',
                    //             style: MyTextStyles.body,
                    //           ),
                    //           defaultActionText: 'OK',
                    //           action: () {},
                    //         ),
                    //       );
                    //     },
                    //     child: Text('Alertダイアログ')),
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
                                    builder: (context) => const SignUpPage()));
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
