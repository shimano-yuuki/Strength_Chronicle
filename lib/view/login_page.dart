import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workout_app/service.dart';
import 'package:workout_app/textstyle.dart';
import 'package:workout_app/view/signup_page.dart';
import 'package:workout_app/view/widget/text_form.dart';

import '../app.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    'Login',
                    style: MyTextStyles.title.large.bold,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async{
                            final service = AuthService();
                            await service.signIn();
                            await Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
                          },
                          child: LoginIconWidget(
                            logoId: 'assets/images/google-logo.svg',
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: LoginIconWidget(
                            logoId: 'assets/images/x-logo.svg',
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: LoginIconWidget(
                            logoId: 'assets/images/apple-logo.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
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
                  SizedBox(
                    height: 60,
                  ),
                  TextFormWidget(
                    icon: Icon(Icons.mail),
                    labelText: 'メールアドレス',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormWidget(
                    icon: Icon(Icons.lock),
                    labelText: 'パスワード',
                    obscure: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'パスワードをお忘れのかた',
                      style: MyTextStyles.label.blue,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ///
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
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
                  SizedBox(
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
                  SizedBox(
                    height: 60,
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
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(1, 1),
            )
          ]),
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
