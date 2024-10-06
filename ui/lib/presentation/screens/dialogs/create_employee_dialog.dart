import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/presentation/components/action_button.dart';
import 'package:hours_control/presentation/components/custom_form_field.dart';
import 'package:hours_control/presentation/components/feedback_snack_bar.dart';
import 'package:hours_control/presentation/components/select_input_field.dart';
import 'package:hours_control/presentation/components/text_input_field.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class CreateEmployeeDialog extends StatefulWidget {
  const CreateEmployeeDialog({super.key});

  @override
  State<CreateEmployeeDialog> createState() => _CreateEmployeeDialogState();
}

class _CreateEmployeeDialogState extends State<CreateEmployeeDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _employeeEstimatedHoursController = TextEditingController();
  final ValueNotifier<int?> _employeeSquadId = ValueNotifier<int?>(null);

  List<DropdownMenuItem<dynamic>> _getSquadItems() {
    List<DropdownMenuItem<dynamic>> squads = platformStore.squadList.map((squad) {
      return DropdownMenuItem<dynamic>(
        value: squad.id,
        child: Text("${squad.id} - ${squad.name}"),
      );
    }).toList();

    if (squads.isNotEmpty) {
      _employeeSquadId.value = squads.first.value;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          scrollable: true,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: EdgeInsets.zero,
          shadowColor: const Color(0xFF212429).withOpacity(0.05),
          titlePadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          titleTextStyle: Theme.of(context).textTheme.headlineMedium,
          title: SizedBox(
            width: platformStore.isMobile ? MediaQuery.of(context).size.width * 0.75 : 415,
            child: const Text(
              "Criar Usuário",
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(top: 32, bottom: 64),
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actions: [
            ActionButton(
              text: "Criar usuário",
              isDisabled: platformStore.isCreatingEmployee,
              isLoading: platformStore.isCreatingEmployee,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  platformStore.setIsCreatingEmployee(true);
                  try {
                    await Future.delayed(const Duration(seconds: 2), () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        FeedbackSnackBar.build(
                          context,
                          message: "Usuário criado!",
                          type: SnackbarType.success,
                        ),
                      );
                      Navigator.of(context).pop();
                    });
                  } catch (error) {
                    print("ERROR: $error");
                  } finally {
                    platformStore.setIsCreatingEmployee(false);
                  }
                }
              },
            ),
          ],
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          content: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFormField(
                  fieldText: "Nome do Usuário",
                  child: TextInputField(
                    controller: _employeeNameController,
                    placeholder: "Digite o nome do usuário",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O usuário deve ter algum nome!";
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      print("FIELD SUBMITTED: $value");
                    },
                  ),
                ),
                const SizedBox(height: 32),
                CustomFormField(
                  fieldText: "Horas estimadas de trabalho",
                  child: TextInputField(
                    controller: _employeeEstimatedHoursController,
                    keyboardType: TextInputType.number,
                    placeholder: "Digite a quantidade de horas",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O usuário deve ter uma estimativa de horas!";
                      }

                      int numericValue = int.parse(value);
                      if (numericValue < 1 && numericValue > 12) {
                        return "As horas estimadas devem estar entre 1 e 12!";
                      }

                      return null;
                    },
                    onFieldSubmitted: (value) {
                      print("FIELD SUBMITTED: $value");
                    },
                  ),
                ),
                const SizedBox(height: 32),
                CustomFormField(
                  fieldText: "Squad",
                  child: SelectInputField(
                    validator: (value) {
                      return null;
                    },
                    placeholder: "Selecione uma Squad",
                    items: _getSquadItems(),
                    onChanged: (dynamic value) {
                      print(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
