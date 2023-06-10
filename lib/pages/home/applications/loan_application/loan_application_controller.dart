import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/model/biometric_credential.dart';
import 'package:ontochain_mobile_wallet/model/loan_application.dart';
import 'package:ontochain_mobile_wallet/model/loan_offer.dart';
import 'package:ontochain_mobile_wallet/service/auth_service.dart';
import 'package:ontochain_mobile_wallet/service/biometric_bureau_service.dart';
import 'package:ontochain_mobile_wallet/service/credit_bureau_service.dart';
import 'package:ontochain_mobile_wallet/service/service_exception.dart';

class LoanApplicationController extends GetxController {
  final _cbService = Get.find<CreditBureauService>();
  final _bbService = Get.find<BiometricBureauService>();
  final _authService = Get.find<AuthService>();

  var publicKey = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var age = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;

  var offers = List<LoanOffer>.empty().obs;
  Rxn<LoanOffer> selectedOffer = Rxn();

  var credentials = List<BiometricCredential>.empty().obs;
  var selectedCredentials = List<BiometricCredential>.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();
    _loadPersonalData();
    _loadOffers();
  }

  Future<void> _loadOffers() async {
    offers.value = await _cbService.getOffers().toList();
  }

  Future<void> _loadPersonalData() async {
    final personalData = (await _authService.getPersonalData())!;
    publicKey.value = personalData.publicKey;
    firstName.value = personalData.firstName;
    lastName.value = personalData.lastName;
    age.value = personalData.age.toString();
    phone.value = personalData.phone;
    email.value = personalData.email;
    credentials.value = await _bbService.getCredentials().toList();
  }

  isCredentialSelected(BiometricCredential credential) =>
      selectedCredentials.contains(credential);

  onSelectCredential(BiometricCredential credential) {
    selectedCredentials.add(credential);
  }

  Future<void> submit() async {
    if (!_validateInput()) {
      return;
    }
    try {
      final form = LoanApplicationForm(
        offerId: selectedOffer.value!.id,
        publicKey: publicKey.value,
        firstName: firstName.value,
        lastName: lastName.value,
        age: int.parse(age.value),
        phone: phone.value,
        email: email.value,
        credentials: selectedCredentials,
      );
      await _cbService.submitApplication(form);
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
        _validateOffer() &&
        _validateCredentials() &&
        _validateAge();
  }

  bool _validateOffer() {
    if (selectedOffer.value == null) {
      Get.snackbar('Error', 'Please select an offer!');
      return false;
    }
    return true;
  }

  bool _validateCredentials() {
    if (selectedCredentials.isEmpty) {
      Get.snackbar('Error', 'Please select at least one credential!');
      return false;
    }
    return true;
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

  bool _validateAge() {
    if (age.value.isEmpty) {
      Get.snackbar('Error', "Age cannot be empty!");
      return false;
    }
    return true;
  }
}
