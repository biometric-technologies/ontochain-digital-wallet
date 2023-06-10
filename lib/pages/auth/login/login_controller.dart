import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/service/auth_service.dart';
import 'package:ontochain_mobile_wallet/service/service_exception.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();

  login() async {
    try {
      final authenticated = await _authService.login();
      if (authenticated) {
        Get.toNamed('/home');
      } else {
        bool registeredSuccess = await Get.toNamed('/register');
        if (registeredSuccess) {
          Get.toNamed('/home');
        } else {
          Get.snackbar('Error', 'Registration failed');
        }
      }
    } on ServiceException catch (e) {
      Get.snackbar('Error', e.message);
    }
  }
}
