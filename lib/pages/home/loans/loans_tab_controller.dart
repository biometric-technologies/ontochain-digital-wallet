import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/model/loan.dart';
import 'package:ontochain_mobile_wallet/service/credit_bureau_service.dart';

class LoansTabController extends GetxController {
  final _cbService = Get.find<CreditBureauService>();
  var loans = List<Loan>.empty().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    loans.value = await _cbService.getLoans().toList();
    isLoading.value = false;
  }
}
