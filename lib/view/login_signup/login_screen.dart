import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:my_news_app/view/login_signup/signup_screen.dart";

import "../../utilities/app_text.dart";
import "../../utilities/widgets/around_button_widget.dart";
import "../../utilities/widgets/text_form_field_widget.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double heightX = Get.height * 1;
    double widthX = Get.width * 1;
    return Scaffold(
        body: FloatingBoxWidget(
          heightX: heightX,
          widthX: widthX,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20),
                  child: AppText(
                    title: 'Login',
                    fontSize: heightX * .026,
                    textFontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: heightX*.020,),

                TextFormFieldWidget(
                  ctrl: controller,
                  keyType: TextInputType.emailAddress,
                  labelText: 'Email address',
                  returnMessage: 'Enter your email',
                  // iconPath: '',
                  width: widthX,
                ),

                SizedBox(height: heightX*.015,),

                TextFormFieldWidget(
                  ctrl: controller,
                  keyType: TextInputType.text,
                  labelText: 'Password',
                  returnMessage: 'Enter your email',
                  // iconPath: '',
                  width: widthX,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: AroundButtonWidget(
                      widthX: widthX,
                      title: 'Login',
                      bgColor: Colors.red,
                      fontSize: 16,
                      showIcon: false,
                      onTap: (){}),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: AroundButtonWidget(
                      widthX: widthX,
                      title: 'Create new account',
                      bgColor: Colors.white,
                      textColor: Colors.red,
                      fontSize: 16,
                      showIcon: false,
                      onTap: (){
                        Get.to(()=> const SignupScreen());
                      }),
                ),


              ],
            ),
          ),
        ));
  }
}
