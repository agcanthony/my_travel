import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_controller.dart';
import 'widgets/pick_date_travel.dart';

class AddTravelPage extends StatelessWidget {
  AddTravelPage({Key? key}) : super(key: key);
  static const routeName = '/add_travel';
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.backButton();
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text('Adicionar Viagem'),
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(24, 50, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: controller.travelController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, uma viagem';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text('Viagem'),
                    ),
                  ),
                  SizedBox(height: 15),
                  PickDateTravel(
                    onTap: () {
                      controller.chooseDateRangePicker();
                    },
                  ),
                  SizedBox(height: 15),
                  controller.getTravelColors(),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: controller.addTravelButton,
                    child: Text('ADICIONAR'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
