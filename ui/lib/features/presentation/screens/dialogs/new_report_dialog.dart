import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/features/domain/entities/employee_entity.dart';
import 'package:hours_control/features/domain/entities/report_entity.dart';
import 'package:hours_control/features/domain/usecases/create_report.dart';
import 'package:hours_control/features/domain/usecases/fetch_employees.dart';
import 'package:hours_control/features/presentation/components/action_button.dart';
import 'package:hours_control/features/presentation/components/custom_form_field.dart';
import 'package:hours_control/features/presentation/components/feedback_snack_bar.dart';
import 'package:hours_control/features/presentation/components/select_input_field.dart';
import 'package:hours_control/features/presentation/components/text_input_field.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class NewReportDialog extends StatefulWidget {
  const NewReportDialog({super.key});

  @override
  State<NewReportDialog> createState() => _NewReportDialogState();
}

class _NewReportDialogState extends State<NewReportDialog> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<int?> _reportEmployeeId = ValueNotifier<int?>(null);
  final TextEditingController _reportSpentHours = TextEditingController();
  final TextEditingController _reportDescription = TextEditingController();

  List<DropdownMenuItem<int>> _getEmployeetems() {
    List<EmployeeEntity> employeeList = [];

    if (platformStore.employeeList.isEmpty) {
    } else {
      employeeList = platformStore.employeeList;
    }

    List<DropdownMenuItem<int>> employees = employeeList.map((employee) {
      return DropdownMenuItem<int>(
        value: employee.id,
        child: Text("${employee.id} - ${employee.name}"),
      );
    }).toList();

    if (employees.isNotEmpty) {
      _reportEmployeeId.value = employees.first.value;
    }

    return employees;
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      Map<String, String> newReport = {
        "description": _reportDescription.text,
        "spentHours": _reportSpentHours.text,
        "employeeId": _reportEmployeeId.value.toString(),
      };
      final CreateReportUseCase createReportUseCase = GetIt.I.get<CreateReportUseCase>();

      platformStore.setIsCreatingReport(true);
      try {
        ReportEntity createdReport = await createReportUseCase.call(
          params: newReport,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          FeedbackSnackBar.build(
            context,
            message: "Horas lançadas!",
            type: SnackbarType.success,
          ),
        );

        EmployeeEntity? squadEmployee = platformStore.squadEmployees.firstWhereOrNull(
          (employee) => employee.id == int.parse(newReport["employeeId"]!),
        );
        if (platformStore.selectedSquad != null && squadEmployee != null) {
          List<ReportEntity> newList = [createdReport, ...platformStore.squadReportsList];
          platformStore.setSquadReportsList(newList);
        }
        Navigator.of(context).pop();
      } catch (error) {
        print("ERROR: $error");
      } finally {
        platformStore.setIsCreatingReport(false);
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
              "Criar lançamento",
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(top: 32, bottom: 64),
          actions: [
            ActionButton(
              text: "Criar lançamento",
              isDisabled: platformStore.isCreatingReport,
              isLoading: platformStore.isCreatingEmployee,
              onPressed: _handleSubmit,
            ),
          ],
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFormField(
                  fieldText: "ID do Usuário",
                  child: SelectInputField(
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return "O ID do usuário deve ser informado!";
                      }

                      bool employeeExists = platformStore.employeeList.firstWhereOrNull(
                            (employee) => employee.id == value,
                          ) !=
                          null;
                      if (!employeeExists) {
                        return "Usuário inexistente!";
                      }

                      return null;
                    },
                    placeholder: "Selecione um usuário",
                    items: _getEmployeetems(),
                    selectedItem: _reportEmployeeId.value,
                    onChanged: (int? value) {
                      _reportEmployeeId.value = value;
                    },
                  ),
                ),
                const SizedBox(height: 32),
                CustomFormField(
                  fieldText: "Horas Gastas",
                  child: TextInputField(
                    controller: _reportSpentHours,
                    keyboardType: TextInputType.number,
                    placeholder: "Digite a quantidade de horas",
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return "A hora gasta deve ser informada!";
                      }

                      int numericValue = int.parse(value);
                      if (numericValue <= 0) {
                        return "Deve ser registrada pelo menos 1 hora";
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
                  fieldText: "descrição",
                  child: TextInputField(
                    controller: _reportDescription,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    placeholder: "Digite a descrição",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A descrição deve ser informada!";
                      }

                      return null;
                    },
                    onFieldSubmitted: (value) {
                      print("FIELD SUBMITTED: $value");
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
