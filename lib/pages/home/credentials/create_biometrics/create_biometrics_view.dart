import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_biometrics_controller.dart';

class CreateBiometricsView extends GetView<CreateBiometricsController> {
  const CreateBiometricsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Face Biometrics')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Obx(() {
                if (controller.pictures.isEmpty) {
                  return const Text('No image selected.');
                } else {
                  return SizedBox(
                    height: 120,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: controller.pictures.map((e) {
                        return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.file(e));
                      }).toList(),
                    ),
                  );
                }
              }),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.selectPictures,
                child: const Text('Take a Picture'),
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
