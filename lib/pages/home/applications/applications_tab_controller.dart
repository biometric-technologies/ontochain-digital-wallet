import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/model/loan_application.dart';

class ApplicationsTabController extends GetxController {
  var loans = List<LoanApplication>.empty(growable: true).obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    loadLoans();
    super.onInit();
  }

  void loadLoans() async {
    isLoading.value = true;
    loans.addAll([
      LoanApplication(
          id: '6458d3bbfab35845e119f248',
          offerId: '6458d3bbfab35845e119f248',
          amount: 1000.0,
          status: "OPEN",
          meta: {},
          createdAt: DateTime.now()),
    ]);
    isLoading.value = false;
  }
}
