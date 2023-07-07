import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quter_api/api/get/images_getx_controller.dart';
import 'package:quter_api/api/models/api_response.dart';
import 'package:quter_api/utlis/helpers.dart';

import '../../api/models/student_image.dart';

class ImagesScreen extends StatefulWidget {
  late String imageGloable;
  ImagesScreen({super.key, required this.imageGloable});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  Widget build(BuildContext context) {
    print('${widget.imageGloable}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        actions: [
          IconButton(
              onPressed: () async {
                Get.toNamed('/upload_image_screen');
              },
              icon: Icon(Icons.upload)),
        ],
      ),
      body: GetX<ImagesGetxController>(
          init: ImagesGetxController(),
          //global: true,
          builder: (controller) {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.images.isNotEmpty) {
              return GridView.builder(
                itemCount: controller.images.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  StudentImage img = controller.images[index];
                  return Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        FadeInImage(
                            placeholder: const NetworkImage(
                                "https://media.istockphoto.com/id/1335247217/vector/loading-icon-vector-illustration.jpg?s=612x612&w=0&k=20&c=jARr4Alv-d5U3bCa8eixuX2593e1rDiiWnvJLgHCkQM="),
                            image: NetworkImage("${img.imageUrl}")),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.black45,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.images[index].image,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Color(0xFF655DBB)),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () => _deleteImage(index: index),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              print(controller.images);
              return Center(
                  child: Text(
                'No Data',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xFF655DBB)),
              ));
            }
          }),
    );
  }

  Future<void> _deleteImage({required int index}) async {
    APIResponse apiResponse =
        await ImagesGetxController.to.deleteImage(index: index);
    Get.snackbar("message", apiResponse.message!,
        backgroundColor: apiResponse.success! ? Colors.green : Colors.red,
        colorText: Colors.white);
  }
}
