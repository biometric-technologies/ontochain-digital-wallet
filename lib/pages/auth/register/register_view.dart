import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/pages/auth/register/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),
              const Text(
                'Please provide your personal information.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                onChanged: (text) => controller.firstName.value = text,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                onChanged: (text) => controller.lastName.value = text,
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                onChanged: (text) => controller.email.value = text,
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                ),
                onChanged: (text) => controller.phone.value = text,
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
                onChanged: (text) => controller.age.value = text,
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (text) => controller.password.value = text,
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                onChanged: (text) => controller.cpassword.value = text,
              ),
              const SizedBox(height: 16),
              Obx(() => TextField(
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Public Key',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    controller: TextEditingController(
                      text: controller.publicKey.value,
                    ),
                  )),
              const SizedBox(height: 16),
              Obx(() => TextField(
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Private Key',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    controller: TextEditingController(
                      text: controller.privateKey.value,
                    ),
                  )),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.generateKeys,
                child: const Text('Generate Keys'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Old Public Key (Only to recover account)',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                onChanged: (text) => controller.oldPublicKey.value = text,
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    labelText: 'Old Password (Only to recover account)'),
                onChanged: (text) => controller.oldPassword.value = text,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: controller.register,
                child: const Text('Register'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
