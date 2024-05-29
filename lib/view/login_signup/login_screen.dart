import "dart:math";

import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:my_news_app/controller/login_signup/login_controller.dart";
import "package:my_news_app/view/home_screen.dart";
import "package:my_news_app/view/login_signup/signup_screen.dart";

import "../../utilities/app_text.dart";
import "../../utilities/widgets/around_button_widget.dart";
import "../../utilities/widgets/text_eye_field_widget.dart";
import "../../utilities/widgets/text_form_field_widget.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginController loginController = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double heightX = Get.height * 1;
    double widthX = Get.width * 1;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.off(()=> const HomeScreen());
      },
        backgroundColor: Colors.red,
      child: const AppText(title: 'Skip', textColor: Colors.white,),
      ),

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
                    fontSize: heightX * .030,
                    textFontWeight: FontWeight.w700,
                  ),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: heightX*.020,),

                      TextFormFieldWidget(
                        ctrl: loginController.emailController,
                        keyType: TextInputType.emailAddress,
                        labelText: 'Email address',
                        returnMessage: 'Enter your email',
                        // iconPath: '',
                        width: widthX,
                        height: heightX*.050,
                      ),

                      SizedBox(height: heightX*.015,),

                      Obx(()=> TextFormEyeWidget(
                        ctrl: loginController.passwordController,
                        keyType: TextInputType.text,
                        labelText: 'Password',
                        returnMessage: 'Enter Password',
                        width: widthX,
                        height: heightX*.050,
                        obscure: loginController.passwordIsVisible.value,
                        eyeTap: () {
                          loginController.passwordIsVisible.value = !loginController.passwordIsVisible.value;
                        },
                      )),
                    ],
                  ),
                ),

                Obx(()=>
                    Padding(
                  padding: EdgeInsets.only(top: heightX*.035),
                  child: AroundButtonWidget(
                      widthX: widthX,
                      height: heightX*.048,
                      title: 'Login',
                      bgColor: Colors.red,
                      fontSize: 16,
                      showIcon: false,
                      loading: loginController.loading.value,
                      onTap: (){
                        loginController.login(_formKey.currentState!.validate());
                      }),
                )),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: AroundButtonWidget(
                      widthX: widthX,
                      title: 'Create new account',
                      height: heightX*.048,
                      bgColor: Colors.white,
                      textColor: Colors.red,
                      fontSize: 16,
                      showIcon: false,
                      onTap: (){
                        Get.to(()=> const SignupScreen());
                      }),
                ),

                Padding(
                  padding: EdgeInsets.only(top: heightX*.015),
                  child: AroundButtonWidget(
                      widthX: widthX,
                      title: 'Continue with Google',
                      height: heightX*.048,
                      bgColor: Colors.white,
                      textColor: Colors.red,
                      fontSize: 16,
                      iconButton: FontAwesomeIcons.google,
                      showIcon: true,
                      onTap: ()async{
                        loginController.loginWithGoogle();
                      }),
                ),


              ],
            ),
          ),
        ));
  }
}
