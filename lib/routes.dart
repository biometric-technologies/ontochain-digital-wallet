import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/pages/auth/login/login_controller.dart';
import 'package:ontochain_mobile_wallet/pages/auth/login/login_view.dart';
import 'package:ontochain_mobile_wallet/pages/auth/login_home/login_home_view.dart';
import 'package:ontochain_mobile_wallet/pages/auth/register/register_controller.dart';
import 'package:ontochain_mobile_wallet/pages/auth/register/register_view.dart';
import 'package:ontochain_mobile_wallet/pages/create_biometrics/create_biometrics_view.dart';
import 'package:ontochain_mobile_wallet/pages/home/applications/applications_tab_controller.dart';
import 'package:ontochain_mobile_wallet/pages/home/credentials/credentials_tab_controller.dart';
import 'package:ontochain_mobile_wallet/pages/home/home_tab_controller.dart';
import 'package:ontochain_mobile_wallet/pages/home/home_view.dart';
import 'package:ontochain_mobile_wallet/pages/home/loans/loans_tab_controller.dart';
import 'package:ontochain_mobile_wallet/pages/loan_application/loan_application_controller.dart';
import 'package:ontochain_mobile_wallet/pages/loan_application/loan_application_view.dart';

import 'pages/create_biometrics/create_biometrics_controller.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: '/',
      page: () => const LoginHomeView(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),
    GetPage(
      name: '/register',
      page: () => const RegisterView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<RegisterController>(() => RegisterController());
      }),
    ),
    GetPage(
      name: '/home',
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeTabController>(() => HomeTabController());
        Get.lazyPut<LoansTabController>(() => LoansTabController());
        Get.lazyPut<CredentialsTabController>(() => CredentialsTabController());
        Get.lazyPut<ApplicationsTabController>(() => ApplicationsTabController());
      }),
    ),
    GetPage(
      name: '/create_biometrics',
      page: () => CreateBiometricsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CreateBiometricsController>(
            () => CreateBiometricsController());
      }),
    ),
    GetPage(
      name: '/loan_application',
      page: () => LoanApplicationView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoanApplicationController>(
            () => LoanApplicationController());
      }),
    ),
  ];
}
