import "dart:math";
import "dart:ui";

import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import "package:get/get.dart";
import "../../controller/login_signup/login_controller.dart";
import "../../controller/userFire/edit_profile_controller.dart";
import "../../utilities/app_text.dart";
import "../../utilities/widgets/around_button_widget.dart";
import "../../utilities/widgets/text_eye_field_widget.dart";
import "../../utilities/widgets/text_form_field_widget.dart";
import "../login_signup/login_screen.dart";

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  EditProfileController editProfileController = Get.put(EditProfileController());
  LoginController loginController = Get.put(LoginController());

  final user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editProfileController.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {

    var heightX = Get.height * 1;
    var widthX = Get.width * 1;
    return Scaffold(
      body: user == null?
      Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bgImage.jpeg',
            fit: BoxFit.cover,
          ),
          // The blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red.withOpacity(0.7),Colors.black.withOpacity(0.6)],
                      begin: FractionalOffset.topLeft, end: AlignmentDirectional.bottomCenter
                  )
              ),
            ),
          ),
          // Your foreground content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Center(
                  child: AppText(
                    title :'Oops!, First you need to Login',
                    fontSize: heightX*.022,
                    textFontWeight: FontWeight.w600,
                    textColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthX*.06),
                child: ElevatedButton(
                  onPressed: (){
                    Get.to(()=> const LoginScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login,
                          color: Colors.white),
                      SizedBox(width: 8),
                      AppText(title: 'Login',textColor: Colors.white,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      )
          :
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Text => Edit Profile
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 60),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: heightX * .020,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  AppText(
                      title: 'Edit Profile',
                      fontSize: heightX * .02,
                      textColor: Colors.black,
                      textFontWeight: FontWeight.w700),
                ],
              ),
            ),
            /// Divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 0.5,
              ),
            ),

            SizedBox(height: heightX*.04,),

            /// Full Name
            TextFormFieldWidget(
              ctrl: editProfileController.fullNameController.value,
              keyType: TextInputType.text,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'FULL NAME',
              width: widthX,
              borderRadius: 40,
              enabledBorderRadius: 30,
              disabledBorderRadius: 30,
            ),

            SizedBox(height: heightX*.03,),

            /// Email
            TextFormFieldWidget(
              ctrl: editProfileController.emailController.value,
              keyType: TextInputType.text,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'E-MAIL',
              width: widthX,
              borderRadius: 40,
              enabledBorderRadius: 30,
              disabledBorderRadius: 30,
            ),

            SizedBox(height: heightX*.03,),

            /// Password
            Obx(()=>
                TextFormEyeWidget(
              ctrl: editProfileController.passwordController.value,
              keyType: TextInputType.text,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'PASSWORD',
              width: widthX,
              borderRadius: 40,
              enabledBorderRadius: 30,
              disabledBorderRadius: 30,
              obscure: loginController.passwordIsVisible.value,
              eyeTap: () {
                loginController.passwordIsVisible.value =
                !loginController.passwordIsVisible.value;
              },
            )),

            AroundButtonWidget(
                onTap: (){
                  editProfileController.updateUserData();
                },
              showIcon: false,
                widthX: widthX,
              bgColor: Colors.red,
                title: 'Update',
                fontSize: heightX*.016,
                 top: heightX*.4,),

          ],
        ),
      ),
    );
  }
}

