import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
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

  List<DropdownMenuItem<dynamic>> _getEmployeetems() {
    List<DropdownMenuItem<dynamic>> employees = platformStore.employeeList.map((squad) {
      return DropdownMenuItem<dynamic>(
        value: squad.id,
        child: Text("${squad.id} - ${squad.name}"),
      );
    }).toList();

    if (employees.isNotEmpty) {
      _reportEmployeeId.value = employees.first.value;
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
              "Criar lançamento",
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(top: 32, bottom: 64),
          actions: [
            ActionButton(
              text: "Criar lançamento",
              isDisabled: platformStore.isCreatingSquad,
              isLoading: platformStore.isCreatingSquad,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  platformStore.setIsCreatingSquad(true);
                  try {
                    await Future.delayed(const Duration(seconds: 2), () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        FeedbackSnackBar.build(
                          context,
                          message: "Horas lançadas!",
                          type: SnackbarType.success,
                        ),
                      );
                      Navigator.of(context).pop();
                    });
                  } catch (error) {
                    print("ERROR: $error");
                  } finally {
                    platformStore.setIsCreatingSquad(false);
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
                  fieldText: "ID do Usuário",
                  child: SelectInputField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O ID do usuário deve ser informado!";
                      }

                      return null;
                    },
                    placeholder: "Selecione um usuário",
                    items: _getEmployeetems(),
                    onChanged: (dynamic value) {
                      print(value);
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
                      if (value == null || value.isEmpty) {
                        return "A hora gasta deve ser informada!";
                      }

                      int numericValue = int.parse(value);
                      if (numericValue < 0) {
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
