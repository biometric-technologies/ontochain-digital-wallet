import 'dart:math';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/service/auth_service.dart';
import 'package:ontochain_mobile_wallet/service/service_exception.dart';
import 'package:pointycastle/export.dart';

class RegisterController extends GetxController {
  final _authService = Get.find<AuthService>();

  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var age = ''.obs;
  var password = ''.obs;
  var cpassword = ''.obs;
  var oldPublicKey = ''.obs;
  var oldPassword = ''.obs;
  var publicKey = ''.obs;
  var privateKey = ''.obs;

  Future<void> register() async {
    if (!_validateInput()) {
      return;
    }
    if (publicKey.value.isEmpty || privateKey.value.isEmpty) {
      Get.snackbar('Error', 'Please generate keys');
      return;
    }
    try {
      await _authService.register(
          firstName.value,
          lastName.value,
          email.value,
          phone.value,
          int.parse(age.value),
          privateKey.value,
          publicKey.value,
          password.value,
          oldPassword: oldPassword.value,
          oldPublicKey: oldPublicKey.value);
      Get.back(result: true);
    } on ServiceException catch (e) {
      Get.snackbar('Error', e.message);
    }
  }

  bool _validateInput() {
    return _validateFirstName() &&
        _validateLastName() &&
        _validateEmail() &&
        _validatePhone() &&
        _validatePassword() &&
        _validateRecover() &&
        _validateAge();
  }

  bool _validateFirstName() {
    if (firstName.value.isEmpty) {
      Get.snackbar('Error', 'First name cannot be empty!');
      return false;
    }
    return true;
  }

  bool _validateLastName() {
    if (lastName.value.isEmpty) {
      Get.snackbar('Error', 'Last name cannot be empty!');
      return false;
    }
    return true;
  }

  bool _validateEmail() {
    if (email.value.isEmpty && email.value.isEmail) {
      Get.snackbar('Error', "Email cannot be empty!");
      return false;
    }
    return true;
  }

  bool _validatePhone() {
    if (phone.value.isEmpty) {
      Get.snackbar('Error', "Phone cannot be empty!");
      return false;
    }
    return true;
  }

  bool _validatePassword() {
    if (password.value.isEmpty) {
      Get.snackbar('Error', "Password cannot be empty!");
      return false;
    }
    if (cpassword.value.isEmpty) {
      Get.snackbar('Error', "Confirm password cannot be empty!");
      return false;
    }
    if (password.value != cpassword.value) {
      Get.snackbar('Error', "Passwords are not the same!");
      return false;
    }
    return true;
  }

  bool _validateRecover() {
    if ((oldPublicKey.value.isEmpty && oldPassword.isNotEmpty) ||
        (oldPublicKey.value.isNotEmpty && oldPassword.isEmpty)) {
      Get.snackbar('Error',
          "Old password and old public key should be provided to recover account!");
      return false;
    }
    return true;
  }

  bool _validateAge() {
    if (age.value.isEmpty) {
      Get.snackbar('Error', "Age cannot be empty!");
      return false;
    }
    return true;
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
}
