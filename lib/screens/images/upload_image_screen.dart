import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quter_api/screens/images/images_screen.dart';
import '../../api/controllers/images_api_controller.dart';
import '../../api/get/images_getx_controller.dart';
import '../../api/models/api_response.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  //final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  double? _progressValue = 0;
  late ImagePicker _imagePicker;
  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Images'),
        actions: [
          IconButton(
              onPressed: () async => await _pickImage(),
              icon: Icon(Icons.camera_alt)),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 10,
            backgroundColor: Colors.green[200],
            color: Colors.green[700],
            value: _progressValue,
          ),
          Expanded(
              child: _pickedImage != null
                  ? Image.file(File(_pickedImage!.path))
                  : IconButton(
                      onPressed: () async => await _pickImage(),
                      icon: Icon(Icons.camera_alt),
                      iconSize: 70,
                      color: Colors.grey,
                    )),
          ElevatedButton.icon(
            onPressed: () async {
               if (_pickedImage != null) {
                  bool isS = await Get.find<ImagesGetxController>()
                      .addImage(path: _pickedImage!.path);
                  Get.snackbar('message', 'FFFF',
                      backgroundColor: isS ? Colors.green : Colors.red);
                }
            },
            icon: Icon(Icons.cloud_upload),
            label: Text('UPLOAD'),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50)),
          )
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? imageFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (imageFile != null) {
      setState(() => _pickedImage = imageFile);
    }
  }
}
