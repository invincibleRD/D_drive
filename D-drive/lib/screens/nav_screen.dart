import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_2/controllers/navigation_controller.dart';
import 'package:my_app_2/screens/files_screen.dart';
import 'package:my_app_2/screens/storage_screen.dart';
import '../widgets/header.dart';

class NavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Header(),
          Obx(
            () => Get.find<NavigationController>().tab.value =="Storage" ? StorageScreen() :FilesScreen(),
          )
        ],
      ),
    );
  }
}