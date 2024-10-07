import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/features/domain/entities/employee_entity.dart';
import 'package:hours_control/features/domain/entities/squad_entity.dart';
import 'package:hours_control/features/presentation/components/action_button.dart';
import 'package:hours_control/features/presentation/components/empty_data.dart';
import 'package:hours_control/features/presentation/components/icon_button.dart';
import 'package:hours_control/features/presentation/components/select_input_field.dart';
import 'package:hours_control/features/presentation/components/text_input_field.dart';
import 'package:hours_control/features/presentation/screens/dialogs/create_employee_dialog.dart';
import 'package:hours_control/features/presentation/themes/main_color_theme.dart';
import 'package:hours_control/shared/period_options.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class SquadDetailsScreen extends StatefulWidget {
  const SquadDetailsScreen({super.key});

  @override
  State<SquadDetailsScreen> createState() => _SquadDetailsScreenState();
}

class _SquadDetailsScreenState extends State<SquadDetailsScreen> {
  late ScrollController _scrollController;
  late SquadEntity squad;
  final TextEditingController _customPeriod = TextEditingController(text: "7");
  final ValueNotifier<int> _period = ValueNotifier<int>(7);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0);
    squad = platformStore.selectedSquad!;
    _fetchSquadMembersHours();
  }

  String _getEmptyText() {
    if (platformStore.squadEmployees.isEmpty) {
      return "Nenhum usuário cadastrado nesta squad. Crie um usuário para começar.";
    }

    return "";
  }

  List<DropdownMenuItem<int>> _getPeriods() {
    List<DropdownMenuItem<int>> periods = periodsOptions.map((period) {
      return DropdownMenuItem<int>(
        value: period["value"],
        child: Text(period["label"]),
      );
    }).toList();

    return periods;
  }

  Future<void> _fetchSquadMembersHours() async {
    try {
      List<EmployeeEntity> squadUsers = platformStore.employeeList
          .where(
            (employee) => employee.squadId == squad.id,
          )
          .toList();

      platformStore.setSquadEmployees(squadUsers);

      if (squadUsers.isNotEmpty) {
        platformStore.setIsFetchingSquadMemberHours(true);
      }
    } catch (error) {
      print("Error fetching squad members hours: $error");
    } finally {
      platformStore.setIsFetchingSquadMemberHours(false);
    }
  }

  List<DataRow> _buildTableData() {
    List<DataRow> dataRowList = [];

    // for (int i = 0; i < platformStore.squadList.length; i++) {
    //   final squad = platformStore.squadList[i];
    //
    //   onPressed() {
    //     platformStore.setSelectedSquad(squad);
    //   }
    //
    //   dataRowList.add(
    //     DataRow(
    //       cells: <DataCell>[
    //         DataCell(
    //           Text(squad.id.toString()),
    //         ),
    //         DataCell(
    //           Text(squad.name),
    //         ),
    //         DataCell(
    //           Align(
    //             alignment: Alignment.centerRight,
    //             child: platformStore.isMobile
    //                 ? CustomIconButton(
    //                     onPressed: onPressed,
    //                     tooltip: "Visitar squad",
    //                     icon: const Icon(
    //                       Icons.group,
    //                       color: Colors.white,
    //                     ),
    //                   )
    //                 : ActionButton(
    //                     text: "Visitar squad",
    //                     onPressed: onPressed,
    //                     height: 33,
    //                   ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return dataRowList;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Padding(
          padding: platformStore.isMobile
              ? const EdgeInsets.all(8)
              : const EdgeInsets.fromLTRB(160, 100, 160, 190),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomIconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 15,
                    ),
                    tooltip: "Back to squad list",
                    onPressed: () {
                      platformStore.setSelectedSquad(null);
                    },
                  ),
                  const SizedBox(width: 24),
                  Text(
                    squad.name,
                    style: platformStore.isMobile
                        ? Theme.of(context).textTheme.headlineSmall
                        : Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  padding: platformStore.isMobile
                      ? const EdgeInsets.symmetric(horizontal: 8, vertical: 10)
                      : const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Horas por membro",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(height: platformStore.isMobile ? 20 : 32),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SelectInputField(
                            placeholder: "Selecione o período",
                            items: _getPeriods(),
                            selectedItem: _period.value,
                            onChanged: (value) {
                              setState(() {
                                _period.value = value ?? 7;
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          if (_period.value == 0)
                            TextInputField(
                              controller: _customPeriod,
                              keyboardType: TextInputType.number,
                              placeholder: "Período customizado",
                            ),
                          const SizedBox(height: 15),
                          ActionButton(
                            text: "Aplicar período",
                            isLoading: platformStore.isFetchingSquadMemberHours,
                            isDisabled: platformStore.isFetchingSquadMemberHours,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Expanded(
                        child: platformStore.isFetchingSquadMemberHours
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).extension<MainColorTheme>()?.blue ??
                                      Colors.blue,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: platformStore.squadEmployees.isEmpty
                                        ? Center(
                                            child: EmptyData(
                                              emptyText: _getEmptyText(),
                                            ),
                                          )
                                        : SingleChildScrollView(
                                            controller: _scrollController,
                                            scrollDirection: Axis.vertical,
                                            keyboardDismissBehavior:
                                                ScrollViewKeyboardDismissBehavior.onDrag,
                                            physics: const AlwaysScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              child: DataTable(
                                                headingRowColor:
                                                    WidgetStateProperty.resolveWith<Color>(
                                                  (Set<WidgetState> states) {
                                                    return Theme.of(context)
                                                            .extension<MainColorTheme>()
                                                            ?.blue ??
                                                        Colors.blue;
                                                  },
                                                ),
                                                headingTextStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                dataTextStyle:
                                                    Theme.of(context).textTheme.bodyMedium,
                                                columns: const <DataColumn>[
                                                  DataColumn(
                                                    headingRowAlignment: MainAxisAlignment.start,
                                                    label: Expanded(
                                                      child: Text('Membro'),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    headingRowAlignment: MainAxisAlignment.start,
                                                    label: Expanded(
                                                      child: Text('Descrição'),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    headingRowAlignment: MainAxisAlignment.start,
                                                    label: Expanded(
                                                      child: Text('Horas'),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    headingRowAlignment: MainAxisAlignment.start,
                                                    label: Expanded(
                                                      child: Text('Criado em'),
                                                    ),
                                                  ),
                                                ],
                                                rows: _buildTableData(),
                                              ),
                                            ),
                                          ),
                                  ),
                                  if (platformStore.squadEmployees.isEmpty)
                                    ActionButton(
                                      text: "Adicionar usuário",
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CreateEmployeeDialog(
                                              squadId: squad.id,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
