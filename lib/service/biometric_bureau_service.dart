import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ontochain_mobile_wallet/constants.dart';
import 'package:ontochain_mobile_wallet/model/biometric_credential.dart';

import 'service_exception.dart';

class BiometricBureauService extends GetxService {
  final _http = GetConnect();
  final _storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    _http.baseUrl = Constants.BIOMETRIC_BUREAU_URL;
  }

  Stream<BiometricCredential> getCredentials() async* {
    final credentialsStr = await _storage.read(key: 'credentials');
    if (credentialsStr != null) {
      final json = jsonDecode(credentialsStr) as List<dynamic>;
      for (var value in json) {
        yield BiometricCredential.fromJson(value);
      }
    }
  }

  Future<void> register(List<Uint8List> biometrics) async {
    final biometricsEncoded = biometrics.map((f) async => base64Encode(f));
    final biometricData = await Future.wait(biometricsEncoded);
    final privateKey = (await _storage.read(key: 'privateKey'))!;
    final publicKey = (await _storage.read(key: 'publicKey'))!;
    final formData = {
      'meta': {},
      'biometrics': biometricData,
      'privateKey': privateKey,
      'publicKey': publicKey,
    };
    final response = await _http.post('/v1/users/auth/register', formData);
    if (!response.status.isOk) {
      throw ServiceException(response.body['message'] ?? response.statusText!);
    }
    final credential = BiometricCredential.fromJson(response.body);
    final credentials = await getCredentials().toList();
    credentials.add(credential);
    final credentialsJson = credentials.map((c) => c.toJson()).toList();
    _storage.write(key: 'credentials', value: jsonEncode(credentialsJson));
  }
}
