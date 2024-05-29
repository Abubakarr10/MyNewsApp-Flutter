import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_news_app/controller/login_signup/login_controller.dart';
import 'package:my_news_app/utilities/app_text.dart';
import 'package:my_news_app/view/profile/edit_profile_screen.dart';

import '../../controller/select_screen_controller.dart';
import '../../controller/share_preferences/share_preferences_controller.dart';
import '../../respository/auth_service_repo.dart';
import '../../utilities/navigation_conts.dart';
import '../login_signup/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  SelectScreenController screenController = Get.put(SelectScreenController());
  LoginController loginController = Get.put(LoginController());

  AuthService authService = AuthService();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double heightX = Get.height * 1;
    double widthX = Get.width * 1;
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                 InkWell(
                   onTap: (){
                     Get.to(()=> const EditProfileScreen());
                   },
                   child: CircleAvatar(
                    foregroundImage: const AssetImage('assets/images/edit-info.png'),
                                   radius: heightX*.09,
                                   ),
                 ),
                SizedBox(height: heightX*.010,),
                 AppText(title: 'Edit Profile',
                  fontSize: heightX*.020,
                  textColor: Colors.red, textFontWeight: FontWeight.w500,)
              ],
            ),
          ),

          SizedBox(height: heightX*.050,),

          Column(
            children: [
              InkWell(
                onTap: ()async{
                  await authService.logout();
                  await saveLoginStatus(false);
                  Get.off(()=> const LoginScreen());
                },
                child: user!=null? CircleAvatar(
                  foregroundImage: const AssetImage('assets/images/log-out.png'),
                  radius: heightX*.09,
                ) : CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: heightX*.09,
                  child: Icon(Icons.login,
                    size: heightX*.09,
                    color: Colors.white,),
                ),

              ),
              SizedBox(height: heightX*.010,),
              SizedBox(
                child: user!=null? AppText(title: 'Logout',
                  fontSize: heightX*.020,
                  textColor: Colors.red, textFontWeight: FontWeight.w500,)
                    :
                AppText(title: 'Login',
                  fontSize: heightX*.020,
                  textColor: Colors.blue, textFontWeight: FontWeight.w500,),
              )
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(()=> FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.red,
          shape: const StadiumBorder(),
          label: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(Navi.iconList.length, (int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                      onTap: () {
                        screenController.selectedIndex.value = Navi.checkList[index];
                        Get.to(Navi.screenList.elementAt(index));
                        if (kDebugMode) {
                          print(screenController.selectedIndex.value.toString());
                        }
                      },
                      child: screenController.selectedIndex.value ==  Navi.checkList[index]? Icon(Navi.iconListFilled.elementAt(index),
                          size: 35, color: Colors.white) :
                      Icon(Navi.iconList.elementAt(index),
                          size: 35, color: Colors.black45)),
                );
              }),
            ),
          ))
      ),
    );
  }
}
