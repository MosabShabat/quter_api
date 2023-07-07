import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quter_api/api/auth/register_screen.dart';
import 'package:quter_api/api/controllers/auth_api_controller.dart';
import '../../screens/users_screens.dart';
import '../../utlis/helpers.dart';
import '../models/api_response.dart';
import 'forgot_password_screen.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: GoogleFonts.actor(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back...',
                  style: GoogleFonts.actor(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 1),
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
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordTextController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
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
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      Get.to(() => ForgotPasswordScreen());
                    },
                    child: Text('Forget Password ?')),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async => await _performLogin(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('LOGIN'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account'),
                    TextButton(
                        onPressed: () {
                          Get.to(() => RegisterScreen());
                        },
                        child: Text('Create Now!'))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performLogin() async {
    if (_checkData()) {
      await _login();
    }
  }

  bool _checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    // showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _login() async {
    APIResponse response = await AuthApiController().login(
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (response.success!) {
      GetStorage().write("userName", response.object!.fullName);
      GetStorage().write("token", response.object!.token);
      Get.off(() => UserScreen());
    } else {
      Get.snackbar("message", response.message!,
          backgroundColor: response.success! ? Colors.green : Colors.red,
          colorText: Colors.white);
    }
  }
}
