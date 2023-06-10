import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/service/biometric_bureau_service.dart';

import '../../../model/biometric_credential.dart';

class CredentialsTabController extends GetxController {
  final _bbService = Get.find<BiometricBureauService>();
  var credentials = List<BiometricCredential>.empty().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    isLoading.value = true;
    credentials.value = await _bbService.getCredentials().toList();
    isLoading.value = false;
  }

  Future<void> addCredentials() async {
    final result = await Get.toNamed('/create_biometrics_dialog');
    if (result == true) {
      await _load();
    }
  }
}
