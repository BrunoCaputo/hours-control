import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/features/presentation/components/action_button.dart';
import 'package:hours_control/features/presentation/components/custom_form_field.dart';
import 'package:hours_control/features/presentation/components/feedback_snack_bar.dart';
import 'package:hours_control/features/presentation/components/text_input_field.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class CreateSquadDialog extends StatefulWidget {
  const CreateSquadDialog({super.key});

  @override
  State<CreateSquadDialog> createState() => _CreateSquadDialogState();
}

class _CreateSquadDialogState extends State<CreateSquadDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _squadNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
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
            "Criar Squad",
            textAlign: TextAlign.center,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(top: 32, bottom: 64),
        actions: [
          ActionButton(
            text: "Criar squad",
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
                        message: "Squad criada!",
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
          child: CustomFormField(
            fieldText: "Nome da Squad",
            child: TextInputField(
              controller: _squadNameController,
              placeholder: "Digite o nome da squad",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "A squad deve ter algum nome!";
                }
                return null;
              },
              onFieldSubmitted: (value) {
                print("FIELD SUBMITTED: $value");
              },
            ),
          ),
        ),
      );
    });
  }
}
