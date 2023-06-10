import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/constants.dart';
import 'package:ontochain_mobile_wallet/model/loan.dart';
import 'package:ontochain_mobile_wallet/model/loan_application.dart';
import 'package:ontochain_mobile_wallet/model/loan_offer.dart';
import 'package:ontochain_mobile_wallet/model/user.dart';

import 'service_exception.dart';

class CreditBureauService extends GetxService {
  final _http = GetConnect();
  final _storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    _http.baseUrl = Constants.CREDIT_BUREAU_URL;
  }

  Future<User> getSelf() async {
    final token = (await _storage.read(key: 'token'))!;
    final response = await _http
        .get('/v1/user/self', headers: {'authentication-token': token});
    if (!response.status.isOk) {
      throw ServiceException(response.body['message'] ?? '');
    }
    return User.fromJson(response.body);
  }

  Stream<LoanOffer> getOffers() async* {
    final token = (await _storage.read(key: 'token'))!;
    final response = await _http
        .get('/v1/user/loan-offers', headers: {'authentication-token': token});
    if (!response.status.isOk) {
      throw ServiceException(response.body['message'] ?? '');
    }
    for (var json in (response.body as List<dynamic>)) {
      final offer = LoanOffer.fromJson(json);
      yield offer;
    }
  }

  Stream<Loan> getLoans() async* {
    final token = (await _storage.read(key: 'token'))!;
    final response = await _http
        .get('/v1/user/loans', headers: {'authentication-token': token});
    if (!response.status.isOk) {
      throw ServiceException(response.body['message'] ?? '');
    }
    for (var json in (response.body as List<dynamic>)) {
      final loan = Loan.fromJson(json);
      yield loan;
    }
  }

  Stream<LoanApplication> getApplications() async* {
    final token = (await _storage.read(key: 'token'))!;
    final response = await _http.get('/v1/user/loan-applications',
        headers: {'authentication-token': token});
    if (!response.status.isOk) {
      throw ServiceException(response.body['message'] ?? '');
    }
    for (var json in (response.body as List<dynamic>)) {
      final application = LoanApplication.fromJson(json);
      yield application;
    }
  }

  Future<void> submitApplication(LoanApplicationForm form) async {
    final token = (await _storage.read(key: 'token'))!;
    final response = await _http.post(
        '/v1/user/loan-applications', form.toJson(),
        headers: {'authentication-token': token});
    if (!response.status.isOk) {
      throw ServiceException(response.body['message'] ?? '');
    }
  }
}
