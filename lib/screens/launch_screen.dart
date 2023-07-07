import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quter_api/screens/users_screens.dart';

import '../api/auth/login_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      //  Get.to(() => LoginScreen());
      GetStorage().read(
                'token',
              ) ==
              null
          ? Get.off(() => LoginScreen())
          : Get.off(() => UserScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [Color(0xFFECF2FF), Color(0xFF3E54AC)])),
        child: Text(
          'Api App',
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xFF655DBB)),
        ),
      ),
    );
  }
}
