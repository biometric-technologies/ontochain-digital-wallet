import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/model/loan_application.dart';
import 'package:ontochain_mobile_wallet/model/loan_offer.dart';
import 'package:ontochain_mobile_wallet/service/credit_bureau_service.dart';

class ApplicationsTabController extends GetxController {
  final _cbService = Get.find<CreditBureauService>();
  final _offers = List<LoanOffer>.empty().obs;

  var applications = List<LoanApplication>.empty().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    _offers.value = await _cbService.getOffers().toList();
    applications.value = await _cbService.getApplications().toList();
    isLoading.value = false;
  }

  String getOfferName(String offerId) =>
      _offers.firstWhereOrNull((el) => el.id == offerId)?.name ?? 'Unknown';

  Future<void> newApplication() async {
    final result = await Get.toNamed('/apply_loan_dialog');
    if (result == true) {
      load();
    }
  }
}
