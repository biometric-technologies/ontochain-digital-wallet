import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ontochain_mobile_wallet/constants.dart';
import 'package:ontochain_mobile_wallet/model/authentication_token.dart';
import 'package:ontochain_mobile_wallet/service/service_exception.dart';

import '../model/personal_data.dart';

class AuthService extends GetxService {
  final _localAuth = LocalAuthentication();
  final _storage = const FlutterSecureStorage();
  final _http = GetConnect();

  @override
  void onInit() {
    super.onInit();
    _http.baseUrl = Constants.CREDIT_BUREAU_URL;
  }

  Future<bool> isRegistered() async {
    final registered = await _storage.read(key: 'registered');
    return registered != null;
  }

  Future<bool> login() async {
    final registered = await _storage.read(key: 'registered');
    if (registered != null) {
      try {
        bool didAuthenticate = await _localAuth.authenticate(
            localizedReason: 'Please authenticate',
            options: const AuthenticationOptions(biometricOnly: false));
        if (didAuthenticate) {
          return true;
        } else {
          throw ServiceException('Authentication failed');
        }
      } on PlatformException catch (e) {
        throw ServiceException(
            'Authentication failed: Please set up passcode or PIN/pattern to use app');
      }
    } else {
      return false;
    }
  }

  Future<void> register(
      String firstName,
      String lastName,
      String email,
      String phone,
      int age,
      String privateKey,
      String publicKey,
      String password,
      {String? oldPassword,
      String? oldPublicKey}) async {
    final data = {
      'password': password,
      'publicKey': publicKey,
      'oldPublicKey': oldPublicKey,
      'oldPassword': oldPassword,
    };
    final response = await _http.post('/v1/user/auth/register', data);
    if (!response.status.isOk) {
      print(response.statusText);
      throw ServiceException(response.body['message'] ?? '');
    }
    final sessionId = AuthenticationToken.fromJson(response.body).id;
    await _storage.write(key: 'token', value: sessionId);
    await _storage.write(key: 'firstName', value: firstName);
    await _storage.write(key: 'lastName', value: lastName);
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'phone', value: phone);
    await _storage.write(key: 'age', value: age.toString());
    await _storage.write(key: 'privateKey', value: privateKey);
    await _storage.write(key: 'publicKey', value: publicKey);
    await _storage.write(key: 'registered', value: true.toString());
  }

  Future<void> logOut() async {
    await _storage.deleteAll();
  }

  Future<PersonalData?> getPersonalData() async {
    final registered = await _storage.read(key: 'registered');
    if (registered == null) {
      return null;
    }
    final publicKey = (await _storage.read(key: 'publicKey'))!;
    final firstName = (await _storage.read(key: 'firstName'))!;
    final lastName = (await _storage.read(key: 'lastName'))!;
    final email = (await _storage.read(key: 'email'))!;
    final phone = (await _storage.read(key: 'phone'))!;
    final age = int.parse((await _storage.read(key: 'age'))!);
    return PersonalData(publicKey, firstName, lastName, email, phone, age);
  }
}
