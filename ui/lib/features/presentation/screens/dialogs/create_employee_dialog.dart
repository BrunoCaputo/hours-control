import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/features/domain/entities/employee_entity.dart';
import 'package:hours_control/features/domain/usecases/create_employee.dart';
import 'package:hours_control/features/presentation/components/action_button.dart';
import 'package:hours_control/features/presentation/components/custom_form_field.dart';
import 'package:hours_control/features/presentation/components/feedback_snack_bar.dart';
import 'package:hours_control/features/presentation/components/select_input_field.dart';
import 'package:hours_control/features/presentation/components/text_input_field.dart';

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

  List<DropdownMenuItem<int>> _getSquadItems() {
    List<DropdownMenuItem<int>> squads = platformStore.squadList.map((squad) {
      return DropdownMenuItem<int>(
        value: squad.id,
        child: Text("${squad.id} - ${squad.name}"),
      );
    }).toList();

    if (squads.isNotEmpty) {
      _employeeSquadId.value = squads.first.value;
    }

    return squads;
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      Map<String, String> newEmployee = {
        "name": _employeeNameController.text,
        "estimatedHours": _employeeEstimatedHoursController.text,
        "squadId": _employeeSquadId.value.toString(),
      };
      final CreateEmployeeUseCase createEmployeeUseCase = GetIt.I.get<CreateEmployeeUseCase>();

      platformStore.setIsCreatingEmployee(true);
      try {
        EmployeeEntity createdEmployee = await createEmployeeUseCase.call(
          params: newEmployee,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          FeedbackSnackBar.build(
            context,
            message: "Usuário criado!",
            type: SnackbarType.success,
          ),
        );
        List<EmployeeEntity> newList = [...platformStore.employeeList, createdEmployee];
        platformStore.setEmployeeList(newList);
        Navigator.of(context).pop();
      } catch (error) {
        print("ERROR: $error");
      } finally {
        platformStore.setIsCreatingEmployee(false);
      }
    }
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
              onPressed: _handleSubmit,
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
                      if (value == null || value.toString().isEmpty) {
                        return "O usuário deve ter uma estimativa de horas!";
                      }

                      int numericValue = int.parse(value);
                      if (numericValue < 1 || numericValue > 12) {
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
                      if (value == null || value.toString().isEmpty) {
                        return "O usuário deve estar em uma squad!";
                      }

                      bool squadExists = platformStore.squadList.firstWhereOrNull(
                            (squad) => squad.id == value,
                          ) !=
                          null;
                      if (!squadExists) {
                        return "O squad inexistente!";
                      }

                      return null;
                    },
                    placeholder: "Selecione uma Squad",
                    items: _getSquadItems(),
                    onChanged: (int? value) {
                      print(value);
                      _employeeSquadId.value = value;
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
