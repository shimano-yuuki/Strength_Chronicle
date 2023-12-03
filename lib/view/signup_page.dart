import 'package:flutter/material.dart';
import 'package:workout_app/service.dart';
import 'package:workout_app/textstyle.dart';
import 'package:workout_app/view/login_page.dart';
import 'package:workout_app/view/widget/text_form.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});

  final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final validatePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  ),
                  SizedBox(
                    height: 40,
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
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '半角英数と記号を含む8文字以上',
                      style: MyTextStyles.label.grey,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormWidget(
                    keyboardType: TextInputType.visiblePassword,
                    controller: validatePasswordController,
                    icon: const Icon(Icons.lock),
                    labelText: '確認用パスワード',
                    obscure: true,
                  ),
                  SizedBox(
                    height: 60,
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
    );
  }
}
