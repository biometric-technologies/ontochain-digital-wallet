import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/service/auth_service.dart';
import 'package:ontochain_mobile_wallet/service/credit_bureau_service.dart';

class AppDrawerController extends GetxController {
  final _authService = Get.find<AuthService>();
  final _cbService = Get.find<CreditBureauService>();

  final name = ''.obs;
  final email = ''.obs;
  final avatar = 'U'.obs;
  final rating = 5.0.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    if (await _authService.isRegistered()) {
      _loadPersonalData();
      _loadCreditData();
    }
  }

  Future<void> _loadPersonalData() async {
    final personal = (await _authService.getPersonalData())!;
    name.value = "${personal.firstName} ${personal.lastName}";
    email.value = personal.email;
    avatar.value = personal.firstName.substring(0, 1);
  }

  Future<void> _loadCreditData() async {
    final self = await _cbService.getSelf();
    rating.value = self.creditScore * .05;
  }

  Future<void> logOut() async {
    await _authService.logOut();
    Get.offAllNamed('/');
  }
}
