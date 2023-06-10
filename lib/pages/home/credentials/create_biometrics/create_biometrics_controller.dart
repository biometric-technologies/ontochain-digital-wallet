import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ontochain_mobile_wallet/service/biometric_bureau_service.dart';
import 'package:ontochain_mobile_wallet/service/service_exception.dart';

class CreateBiometricsController extends GetxController {
  final _bbService = Get.find<BiometricBureauService>();
  final _imagePicker = ImagePicker();

  var files = List<XFile>.empty(growable: true).obs;
  var pictures = List<File>.empty(growable: true).obs;

  void selectPictures() async {
    final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 240,
        maxHeight: 320,
        imageQuality: 90);
    if (pickedFile != null) {
      files.add(pickedFile);
      pictures.add(File(pickedFile.path));
    }
  }

  Future<void> submit() async {
    try {
      await _bbService.register(files);
      Get.back(result: true);
    } on ServiceException catch (e) {
      Get.snackbar('Error', e.message);
    }
  }
}
