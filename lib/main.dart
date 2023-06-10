import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:ontochain_mobile_wallet/routes.dart';
import 'package:ontochain_mobile_wallet/service/auth_service.dart';
import 'package:ontochain_mobile_wallet/service/biometric_bureau_service.dart';
import 'package:ontochain_mobile_wallet/service/credit_bureau_service.dart';
import 'package:ontochain_mobile_wallet/shared/drawer/app_drawer_controller.dart';

void main() {
  Get.put(BiometricBureauService(), permanent: true);
  Get.put(CreditBureauService(), permanent: true);
  Get.put(AuthService(), permanent: true);
  Get.put(AppDrawerController(), permanent: true);
  runApp(const MyApp());
}

final logger = Logger();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ingress Credit Wallet',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages,
      theme: ThemeData().copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
