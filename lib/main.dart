import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quter_api/api/auth/login_screen.dart';
import 'package:quter_api/api/auth/register_screen.dart';
import 'package:quter_api/screens/launch_screen.dart';
import 'package:quter_api/screens/users_screens.dart';

import 'screens/images/images_screen.dart';
import 'screens/images/upload_image_screen.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      getPages: [
        GetPage(name: '/launch_screen', page: () => LaunchScreen()),
        GetPage(name: '/users_screens', page: () => UserScreen()),
        GetPage(name: '/login_screen', page: () => LoginScreen()),
        GetPage(name: '/register_screen', page: () => RegisterScreen()),
        GetPage(
            name: '/image_screen',
            page: () => ImagesScreen(
                  imageGloable: '',
                )),
        GetPage(name: '/upload_image_screen', page: () => UploadImageScreen()),
      ],
    );
  }
}
