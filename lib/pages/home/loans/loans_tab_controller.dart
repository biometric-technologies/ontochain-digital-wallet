import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/model/loan.dart';

class LoansTabController extends GetxController {
  var loans = List<Loan>.empty(growable: true).obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    loadLoans();
    super.onInit();
  }

  void loadLoans() async {
    isLoading.value = true;
    loans.addAll([
      Loan(id: 'Loan @ 8% for 20 days', startDate: '2020-10-01', endDate: '2022-10-21', sumUSD: 500.0, status: 'CLOSED'),
      Loan(id: 'Loan @ 10% for 30 days', startDate: '2021-01-01', endDate: '2022-02-01', sumUSD: 1000.0, status: 'OPEN'),
    ]);
    isLoading.value = false;
  }
}

