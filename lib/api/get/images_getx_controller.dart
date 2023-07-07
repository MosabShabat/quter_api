import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:quter_api/api/controllers/images_api_controller.dart';
import 'package:quter_api/api/models/api_response.dart';
import 'package:quter_api/api/models/student_image.dart';

class ImagesGetxController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<StudentImage> images = <StudentImage>[].obs;
  final ImagesApiController _apiController = ImagesApiController();
  static ImagesGetxController get to => Get.find<ImagesGetxController>();
  @override
  void onInit() {
    getImage();
    super.onInit();
  }

  getImage() async {
    isLoading.value = true;
    images.value = await ImagesApiController().getStudentImage();
    isLoading.value = false;
  }

  addImage({path}) async {
    APIResponse? response = await ImagesApiController().uploadImage(path);
    if (response != null) {
      if (response.success!) {
        images.add(response.object! as StudentImage);
        return true;
      }
    } else {
      return false;
    }
  }

  Future<APIResponse> deleteImage({required int index}) async {
    APIResponse apiResponse =
        await _apiController.deleteImages(id: images[index].id);
    if (apiResponse.success!) {
      images.removeAt(index);
    }
    return apiResponse;
  }
}
