import 'package:get/get.dart';

class RegisterController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var age = ''.obs;

  void register() {
    Get.offAllNamed('/home');
  }

  bool validateInput() {
    return _validateFirstName() &&
        _validateLastName() &&
        _validateEmail() &&
        _validatePhone() &&
        _validateAge();
  }

  bool _validateFirstName() {
    if (firstName.value.isEmpty) {
      print("First name cannot be empty!");
      return false;
    }
    // Implement further validation if needed
    return true;
  }

  bool _validateLastName() {
    if (lastName.value.isEmpty) {
      print("Last name cannot be empty!");
      return false;
    }
    // Implement further validation if needed
    return true;
  }

  bool _validateEmail() {
    if (email.value.isEmpty) {
      print("Email cannot be empty!");
      return false;
    }
    // Implement further validation if needed
    return true;
  }

  bool _validatePhone() {
    if (phone.value.isEmpty) {
      print("Phone cannot be empty!");
      return false;
    }
    // Implement further validation if needed
    return true;
  }

  bool _validateAge() {
    if (age.value.isEmpty) {
      print("Age cannot be empty!");
      return false;
    }
    // Implement further validation if needed
    return true;
  }
}
