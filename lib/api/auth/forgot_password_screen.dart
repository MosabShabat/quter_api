import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quter_api/api/auth/reset_password_screen.dart';

import '../../utlis/helpers.dart';
import '../controllers/auth_api_controller.dart';
import '../models/api_response.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with Helpers {
  late TextEditingController _emailTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'FORGOT PASSWORD',
          style: GoogleFonts.actor(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back...',
              style: GoogleFonts.actor(
                  fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1),
            ),
            Text(
              'Enter email & password',
              style: GoogleFonts.actor(
                fontWeight: FontWeight.w300,
                color: Colors.black45,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailTextController,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async => await _performForgotPassword(),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('SEND'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performForgotPassword() async {
    if (_checkData()) {
      await _forgotPassword();
    }
  }

  bool _checkData() {
    if (_emailTextController.text.isNotEmpty) {
      return true;
    }
    // showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _forgotPassword() async {
    APIResponse response = await AuthApiController().forgotPassword(
      email: _emailTextController.text,
    );
    print(response.success!);
    if (response.success!) {
      Get.to(() => ResetPasswordScreen(email: _emailTextController.text));
    } else {
      Get.snackbar("message", response.message!,
          backgroundColor: response.success! ? Colors.green : Colors.red,
          colorText: Colors.white);
    }
  }
}
