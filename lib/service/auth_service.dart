import 'dart:io';

import 'package:get/get.dart';

class AuthService extends GetxService {
  Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 2)); // simulate a delay
    return username == 'user' && password == 'pass';
  }

  Future<void> register(String publicKey, String privateKey, List<File> biometrics) async {


  }

}