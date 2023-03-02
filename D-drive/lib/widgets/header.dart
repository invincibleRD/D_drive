import 'package:flutter/material.dart';
import 'package:my_app_2/controllers/navigation_controller.dart';
import 'package:my_app_2/utils.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  NavigationController navController = Get.put(NavigationController());
  Widget tabCell( String text,bool selected, BuildContext context){
    return selected ? Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45 -6,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepOrangeAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(-10, 10),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(-10, 10),
              blurRadius: 10,
            )
          ]
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle(23, Colors.white, FontWeight.bold),
          )
        ),
      ),
    )
  : Container(
      width: MediaQuery.of(context).size.width * 0.45 -12,
      height: 60,
      child: Center(
        child: Text(
          text,
          style: textStyle(23, textColor, FontWeight.bold),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              "D-drive",
              style: textStyle(28, textColor, FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade100, 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    offset: const Offset(-10, 10),
                    blurRadius: 10
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    offset: const Offset(10, 10),
                    blurRadius: 10),
              ]),
              child: Obx(
                () =>  Row(
                  children: [
                    InkWell(
                      onTap: () => navController.changeTab("Storage"),
                      child: tabCell("Storage",navController.tab.value == "Storage",context),
                    ),
                    InkWell(
                      onTap: () => navController.changeTab("Files"),
                      child: tabCell("Files",navController.tab.value == "Files",context),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
