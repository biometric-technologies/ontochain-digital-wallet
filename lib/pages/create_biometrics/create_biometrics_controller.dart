import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pointycastle/export.dart';

class CreateBiometricsController extends GetxController {
  final _imagePicker = ImagePicker();

  var publicKey = ''.obs;
  var privateKey = ''.obs;
  var pictures = List<File>.empty(growable: true).obs;

  void selectPictures() async {
    final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 240,
        maxHeight: 320,
        imageQuality: 90);
    if (pickedFile != null) {
      pictures.add(File(pickedFile.path));
    }
  }

  void generateKeys() {
    var keyParams = RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 5);

    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    var keyGenerator = RSAKeyGenerator()
      ..init(ParametersWithRandom(keyParams, secureRandom));
    AsymmetricKeyPair keyPair = keyGenerator.generateKeyPair();

    RSAPublicKey pubKey = keyPair.publicKey as RSAPublicKey;
    RSAPrivateKey privKey = keyPair.privateKey as RSAPrivateKey;

    publicKey.value = pubKey.modulus.toString() + pubKey.exponent.toString();
    privateKey.value = privKey.modulus.toString() + privKey.exponent.toString();
  }

  void submit() async {

  }

}
