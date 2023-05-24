import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/pages/create_biometrics/create_biometrics_controller.dart';

class CreateBiometricsView extends GetView<CreateBiometricsController> {
  CreateBiometricsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Face Biometrics')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Obx(() {
                if (controller.pictures.isEmpty) {
                  return Text('No image selected.');
                } else {
                  return Container(
                    height: 120,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: controller.pictures.map((e) {
                        return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Image.file(e));
                      }).toList(),
                    ),
                  );
                }
              }),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.selectPictures,
                child: Text('Take a Picture'),
              ),
              const SizedBox(height: 16),
              Obx(() => TextField(
                    enabled: false,
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
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
                child: Text('Generate Keys'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: controller.submit,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
