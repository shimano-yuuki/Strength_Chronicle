import 'package:flutter/material.dart';
import 'package:workout_app/service.dart';
import 'package:workout_app/textstyle.dart';
import 'package:workout_app/validate.dart';
import 'package:workout_app/view/login_page.dart';
import 'package:workout_app/view/widget/text_form.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});


  final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final validatePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding:  EdgeInsets.only(
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
                      'Sign Up',
                      style: MyTextStyles.title.large.bold,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'メールアドレス',
                        style: MyTextStyles.body.large.bold,

                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormWidget(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      icon: Icon(Icons.mail),
                      labelText: 'メールアドレス',
                      validateText: ValidateText.email,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'パスワード',
                        style: MyTextStyles.body.large.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormWidget(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      icon: const Icon(Icons.lock),
                      labelText: 'パスワード',
                      obscure: true,
                      validateText: ValidateText.password,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '半角英数時の8文字以上',
                        style: MyTextStyles.label.grey,
                      ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // TextFormWidget(
                    //   keyboardType: TextInputType.visiblePassword,
                    //   controller: validatePasswordController,
                    //   icon: const Icon(Icons.lock),
                    //   labelText: '確認用パスワード',
                    //   obscure: true,
                    // ),
                    SizedBox(
                      height: 56,
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            '新規登録',
                            style: MyTextStyles.body.bold.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'すでにアカウントをお持ちの方は',
                          style: MyTextStyles.label,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            'こちら',
                            style: MyTextStyles.label.blue,
                          ),
                        ),
                      ],
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
