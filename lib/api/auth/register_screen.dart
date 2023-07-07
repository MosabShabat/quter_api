import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quter_api/api/models/student.dart';

import '../../utlis/helpers.dart';
import '../controllers/auth_api_controller.dart';
import '../models/api_response.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late TextEditingController _fullNameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  String _gender = 'M';

  @override
  void initState() {
    super.initState();
    _fullNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameTextController.dispose();
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
          'REGISTER',
          style: GoogleFonts.actor(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New account...',
                  style: GoogleFonts.actor(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 1),
                ),
                Text(
                  'Enter new account details',
                  style: GoogleFonts.actor(
                    fontWeight: FontWeight.w300,
                    color: Colors.black45,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: _fullNameTextController,
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    prefixIcon: const Icon(Icons.person),
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
                  keyboardType: TextInputType.name,
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
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text('Male'),
                        value: 'M',
                        groupValue: _gender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() => _gender = value);
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text('Female'),
                        value: 'F',
                        groupValue: _gender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() => _gender = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async => await _performRegister(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('REGISTER'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performRegister() async {
    if (_checkData()) {
      await _register();
    }
  }

  bool _checkData() {
    if (_fullNameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _register() async {
    APIResponse response = await AuthApiController().register(student: student);
    if (response.success!) {
      Get.back();
    }
    Get.snackbar("message", response.message!,
        backgroundColor: response.success! ? Colors.green : Colors.red,
        colorText: Colors.white);
  }

  Student get student {
    Student student = Student();
    student.fullName = _fullNameTextController.text;
    student.email = _emailTextController.text;
    student.password = _passwordTextController.text;
    student.gender = _gender;
    return student;
  }
}
