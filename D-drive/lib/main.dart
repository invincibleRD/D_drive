import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_2/screens/login_screen.dart';
import 'controllers/authetication_controller.dart';
import 'screens/nav_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp( 
      debugShowCheckedModeBanner: false,
      home: Root(),
    );
  }
}


class Root extends StatelessWidget {
  AuthController authController=Get.put(AuthController());
  

  @override
  Widget build(BuildContext context) {
    return Obx(
      (){
        return authController.user.value == null ? LoginScreen() : NavScreen();
      }
    );
  }
}