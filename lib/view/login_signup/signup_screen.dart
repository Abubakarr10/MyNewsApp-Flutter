import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_news_app/controller/login_signup/signup_controller.dart';
import 'package:my_news_app/utilities/app_text.dart';
import 'package:my_news_app/utilities/widgets/around_button_widget.dart';
import 'package:my_news_app/utilities/widgets/text_form_field_widget.dart';
import 'package:my_news_app/view/login_signup/login_screen.dart';

import '../../utilities/widgets/text_eye_field_widget.dart';
import '../home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  SignupController signupController = Get.put(SignupController());

  @override
  void  dispose(){
    super.dispose();
    signupController.fullNameController.dispose();
    signupController.emailController.dispose();
    signupController.passwordController.dispose();
  }

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: AppText(
                title: 'Sign up',
                fontSize: heightX * .030,
                textFontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: heightX*.010,),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    ctrl: signupController.fullNameController,
                    keyType: TextInputType.text,
                    labelText: 'Full Name',
                    returnMessage: 'Enter Your Name',
                    height: heightX*.050,
                    width: widthX,
                  ),

                  SizedBox(height: heightX*.010,),

                  TextFormFieldWidget(
                    ctrl: signupController.emailController,
                    keyType: TextInputType.emailAddress,
                    labelText: 'Email address',
                    returnMessage: 'Enter Your Email',
                    width: widthX,
                    height: heightX*.050,
                  ),

                  SizedBox(height: heightX*.010,),

                  Obx(()=> TextFormEyeWidget(
                    ctrl: signupController.passwordController,
                    keyType: TextInputType.text,
                    labelText: 'Password',
                    returnMessage: 'Enter Password',
                    width: widthX,
                    height: heightX*.050,
                    obscure: signupController.passwordIsVisible.value,
                    eyeTap: () {
                      signupController.passwordIsVisible.value = !signupController.passwordIsVisible.value;
                    },
                  )),
                ],
              ),
            ),

            Obx(()=>
                Padding(
              padding: EdgeInsets.only(top: heightX*.040),
              child: AroundButtonWidget(
                  widthX: widthX,
                  height: heightX*.045,
                  title: 'Sign up',
                  bgColor: Colors.red,
                  fontSize: 16,
                  showIcon: false,
                  loading: signupController.loading.value,
                  onTap: () async{
                    signupController.signUp(_formKey.currentState!.validate());
                  }),
            )),

            Padding(
              padding: EdgeInsets.only(top: heightX*.015),
              child: AroundButtonWidget(
                  widthX: widthX,
                  height: heightX*.045,
                  title: 'Already a member',
                  bgColor: Colors.white,
                  textColor: Colors.red,
                  fontSize: 16,
                  showIcon: false,
                  onTap: (){
                    Get.to(()=> const LoginScreen());
                  }),
            ),

            Padding(
              padding: EdgeInsets.only(top: heightX*.015),
              child: AroundButtonWidget(
                  widthX: widthX,
                  height: heightX*.045,
                  title: 'Sign up with Google',
                  bgColor: Colors.white,
                  textColor: Colors.red,
                  fontSize: 16,
                  iconButton: FontAwesomeIcons.google,
                  showIcon: true,
                  onTap: ()async{
                   signupController.signUpWithGoogle();
                  }),
            ),


          ],
        ),
      ),
    ));
  }
}

class FloatingBoxWidget extends StatelessWidget {
  FloatingBoxWidget(
      {super.key,
      required this.heightX,
      required this.widthX,
      required this.child});

  final double heightX;
  final double widthX;
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/bgImage.jpeg'),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            )),
          ),
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  Colors.red.withOpacity(0.5),
                  Colors.black.withOpacity(0.5)
                ],
                    begin: FractionalOffset.centerLeft,
                    end: Alignment.bottomCenter)),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: heightX*.8,
              margin: const EdgeInsets.only(top: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [

                  Container(
                    height: heightX *.75,
                    width: widthX,
                    margin: EdgeInsets.symmetric(
                      horizontal: widthX * .1, vertical: 60,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(60)),
                    child: child,
                  ),

                  Positioned(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CircleAvatar(
                            radius: heightX*.055,
                            foregroundImage: const AssetImage('assets/images/news_app_logo.png'),
                            //child: Image.asset('assets/images/bgImage.jpeg'),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
