import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/pages/auth/login/login_controller.dart';
import 'package:ontochain_mobile_wallet/pages/auth/login/login_view.dart';
import 'package:ontochain_mobile_wallet/pages/auth/register/register_controller.dart';
import 'package:ontochain_mobile_wallet/pages/auth/register/register_view.dart';
import 'package:ontochain_mobile_wallet/pages/home/applications/applications_tab_controller.dart';
import 'package:ontochain_mobile_wallet/pages/home/credentials/create_biometrics/create_biometrics_controller.dart';
import 'package:ontochain_mobile_wallet/pages/home/credentials/create_biometrics/create_biometrics_view.dart';
import 'package:ontochain_mobile_wallet/pages/home/credentials/credentials_tab_controller.dart';
import 'package:ontochain_mobile_wallet/pages/home/home_tab_controller.dart';
import 'package:ontochain_mobile_wallet/pages/home/home_view.dart';
import 'package:ontochain_mobile_wallet/pages/home/loans/loans_tab_controller.dart';

import 'pages/home/applications/loan_application/loan_application_controller.dart';
import 'pages/home/applications/loan_application/loan_application_view.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: '/',
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      name: '/register',
      page: () => const RegisterView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RegisterController());
      }),
    ),
    GetPage(
      name: '/home',
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeViewController());
        Get.lazyPut(() => LoansTabController());
        Get.lazyPut(() => CredentialsTabController());
        Get.lazyPut(() => ApplicationsTabController());
      }),
    ),
    GetPage(
      name: '/create_biometrics_dialog',
      page: () => const CreateBiometricsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreateBiometricsController());
      }),
      fullscreenDialog: true,
    ),
    GetPage(
      name: '/apply_loan_dialog',
      page: () => const LoanApplicationView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoanApplicationController());
      }),
      fullscreenDialog: true,
    )
  ];
}
