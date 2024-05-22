import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_news_app/utilities/app_text.dart';
import 'package:my_news_app/utilities/widgets/around_button_widget.dart';
import 'package:my_news_app/utilities/widgets/text_form_field_widget.dart';
import 'package:my_news_app/view/login_signup/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: AppText(
                title: 'Sign up',
                fontSize: heightX * .026,
                textFontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: heightX*.010,),

            TextFormFieldWidget(
              ctrl: controller,
              keyType: TextInputType.text,
              labelText: 'Full Name',
              returnMessage: 'Enter your Name',
              // iconPath: '',
              width: widthX,
            ),

            SizedBox(height: heightX*.015,),

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
                  title: 'Sign up',
                  bgColor: Colors.red,
                  fontSize: 16,
                  showIcon: false,
                  onTap: (){}),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: AroundButtonWidget(
                  widthX: widthX,
                  title: 'Already a member',
                  bgColor: Colors.white,
                  textColor: Colors.red,
                  fontSize: 16,
                  showIcon: false,
                  onTap: (){
                    Get.to(()=> const LoginScreen());
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
              height: heightX*.6,
              margin: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  Container(
                    height: heightX * .5,
                    width: widthX,
                    margin: EdgeInsets.symmetric(
                      horizontal: widthX * .1, vertical: 60,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(60)),
                    child: child,
                  ),
                  const Positioned(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                          radius: 60,
                          foregroundImage: AssetImage('assets/images/news_app_logo.png'),
                          //child: Image.asset('assets/images/bgImage.jpeg'),
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
