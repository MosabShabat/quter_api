import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quter_api/api/controllers/auth_api_controller.dart';
import 'package:quter_api/api/controllers/users_api_controller.dart';
import 'package:quter_api/api/models/api_response.dart';
import 'package:quter_api/api/models/user.dart';
import 'package:quter_api/screens/images/images_screen.dart';
import 'package:quter_api/utlis/helpers.dart';

import '../api/auth/login_screen.dart';

class UserScreen extends StatelessWidget with Helpers {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
              onPressed: () async {
                Get.toNamed('/image_screen');
              },
              icon: Icon(Icons.image)),
          IconButton(
              onPressed: () async {
                await _logout();
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder<List<User>?>(
        future: UserApiController().read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(snapshot.data![index].image),
                    ),
                    title: Text(snapshot.data![index].firstName),
                    subtitle: Text(snapshot.data![index].email),
                  );
                });
          } else {
            return Center(
                child: Text(
              'No Data',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF655DBB)),
            ));
          }
        },
      ),
    );
  }

  Future<void> _logout() async {
    APIResponse response = await AuthApiController().logout();
    print(response.success);
    if (response.success!) {
      Get.off(() => LoginScreen());
    }
    Get.snackbar("message", response.message!,
        backgroundColor: response.success! ? Colors.green : Colors.red,
        colorText: Colors.white);

    // APIResponse apiResponse = await AuthApiController().logout();
    // print(apiResponse.success);
    // if (apiResponse.success!) {
    //   Get.off(() => LoginScreen());
    // }
    // showSnackBar(context,
    //     message: apiResponse.message!, error: apiResponse.success!);
  }
}
