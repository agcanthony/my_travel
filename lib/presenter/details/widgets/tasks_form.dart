import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/app_colors.dart';
import '../../../core/primary_text.dart';
import '../details_controller.dart';

class TasksForm extends StatelessWidget {
  const TasksForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return GetBuilder<DetailsController>(
      builder: (control) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: control.taskController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Adicionar Entrada',
                prefixIcon: Icon(
                  Icons.check_box_outline_blank_outlined,
                  color: grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor, adicione uma Entrada';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            ExpansionTile(
              // expanded: control.isExpanded.value, // Add this line
              onExpansionChanged: (value) => control.isExpanded.value = value,
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: PrimaryText(
                'Salvar/Ver mais',
                color: changeTheme ? lilyWhite : black,
                textAlign: TextAlign.center,
              ),
              children: <Widget>[
                TextFormField(
                  controller: control.descriptionController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Descrição - (Opcional)',
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank_outlined,
                      color: grey,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: control.dateController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'Data',
                          prefixIcon: Icon(
                            Icons.check_box_outline_blank_outlined,
                            color: grey,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 5),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                            control.dateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: control.timeController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'Horário',
                          prefixIcon: Icon(
                            Icons.check_box_outline_blank_outlined,
                            color: grey,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            // ignore: use_build_context_synchronously
                            String formattedTime = pickedTime.format(context);
                            control.timeController.text = formattedTime;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    control.saveTask();
                    control.collapseExpansionTile();
                  },
                  child: const Text('Salvar'),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        );
      },
    );
  }
}
