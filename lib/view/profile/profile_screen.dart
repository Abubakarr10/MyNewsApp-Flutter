import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_news_app/utilities/app_text.dart';

import '../../controller/select_screen_controller.dart';
import '../../utilities/navigation_conts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  SelectScreenController screenController = Get.put(SelectScreenController());


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const AppText(title: 'Profile',fontSize: 24,),
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
