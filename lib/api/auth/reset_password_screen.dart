import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quter_api/api/auth/login_screen.dart';

import '../../utlis/helpers.dart';
import '../../widgets/code_text_field.dart';
import '../controllers/auth_api_controller.dart';
import '../models/api_response.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with Helpers {
  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  late TextEditingController _passwordTextController;
  late TextEditingController _passwordConfirmationTextController;

  String _code = '';

  @override
  void initState() {
    super.initState();
    _passwordTextController = TextEditingController();
    _passwordConfirmationTextController = TextEditingController();

    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordTextController.dispose();
    _passwordConfirmationTextController.dispose();

    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'RESET PASSWORD',
          style: GoogleFonts.actor(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset password...',
              style: GoogleFonts.actor(
                  fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1),
            ),
            Text(
              'Enter code & new password',
              style: GoogleFonts.actor(
                fontWeight: FontWeight.w300,
                color: Colors.black45,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CodeTextField(
                  controller: _firstCodeTextController,
                  focusNode: _firstFocusNode,
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _secondFocusNode.requestFocus();
                    }
                  },
                  onSubmitted: (String value) {},
                ),
                const SizedBox(width: 10),
                CodeTextField(
                  controller: _secondCodeTextController,
                  focusNode: _secondFocusNode,
                  onChanged: (String value) {
                    value.isNotEmpty
                        ? _thirdFocusNode.requestFocus()
                        : _firstFocusNode.requestFocus();
                  },
                  onSubmitted: (String value) {},
                ),
                const SizedBox(width: 10),
                CodeTextField(
                  controller: _thirdCodeTextController,
                  focusNode: _thirdFocusNode,
                  onChanged: (String value) {
                    value.isNotEmpty
                        ? _fourthFocusNode.requestFocus()
                        : _secondFocusNode.requestFocus();
                  },
                  onSubmitted: (String value) {},
                ),
                const SizedBox(width: 10),
                CodeTextField(
                  controller: _fourthCodeTextController,
                  focusNode: _fourthFocusNode,
                  onChanged: (String value) {
                    if (value.isEmpty) {
                      _thirdFocusNode.requestFocus();
                    }
                  },
                  onSubmitted: (String value) {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordConfirmationTextController,
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
            TextField(
              controller: _passwordTextController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async => await _performResetPassword(),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('RESET'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performResetPassword() async {
    if (_checkData()) {
      await _resetPassword();
    }
  }

  bool _checkData() {
    return _checkCode() && _checkPassword();
  }

  bool _checkPassword() {
    if (_passwordTextController.text.isNotEmpty &&
        _passwordConfirmationTextController.text.isNotEmpty) {
      if (_passwordTextController.text ==
          _passwordConfirmationTextController.text) {
        return true;
      }
      showSnackBar(context,
          message: 'Password confirmation error', error: true);
      return false;
    }
    showSnackBar(context,
        message: 'Enter password & confirmation', error: true);
    return false;
  }

  bool _checkCode() {
    _code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;
    if (_code.length == 4) {
      return true;
    }
    showSnackBar(context, message: 'Code is not correct', error: true);
    return false;
  }

  Future<void> _resetPassword() async {
    APIResponse response = await AuthApiController().resetPassword(
      email: widget.email,
      password: _passwordConfirmationTextController.text,
      code: _code,
    );
      if (response.success!) {
      Get.to(() => const LoginScreen());
    }
    Get.snackbar("message", response.message!,
        backgroundColor: response.success! ? Colors.green : Colors.red,
        colorText: Colors.white);
  }
}
