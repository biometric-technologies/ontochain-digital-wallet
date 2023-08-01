import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ontochain_mobile_wallet/service/biometric_bureau_service.dart';
import 'package:ontochain_mobile_wallet/service/service_exception.dart';
import 'package:image/image.dart' as img;

class CreateBiometricsController extends GetxController {
  final _bbService = Get.find<BiometricBureauService>();
  final _imagePicker = ImagePicker();

  var files = List<Uint8List>.empty(growable: true).obs;
  var pictures = List<File>.empty(growable: true).obs;

  void selectPictures() async {
    final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 240,
        maxHeight: 320,
        imageQuality: 100);
    if (pickedFile != null) {
      final captured = img.decodeImage(await pickedFile.readAsBytes())!;
      final fixedOrientation = img.bakeOrientation(captured);
      files.add(img.encodeJpg(fixedOrientation));
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
