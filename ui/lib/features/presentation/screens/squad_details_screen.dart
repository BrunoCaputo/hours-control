import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/features/domain/entities/employee_entity.dart';
import 'package:hours_control/features/domain/entities/report_entity.dart';
import 'package:hours_control/features/domain/entities/squad_entity.dart';
import 'package:hours_control/features/domain/models/squad_member_hours.dart';
import 'package:hours_control/features/domain/usecases/get_reports_by_squad_id.dart';
import 'package:hours_control/features/domain/usecases/get_squad_member_hours.dart';
import 'package:hours_control/features/presentation/components/action_button.dart';
import 'package:hours_control/features/presentation/components/empty_data.dart';
import 'package:hours_control/features/presentation/components/icon_button.dart';
import 'package:hours_control/features/presentation/components/select_input_field.dart';
import 'package:hours_control/features/presentation/components/text_input_field.dart';
import 'package:hours_control/features/presentation/screens/dialogs/create_employee_dialog.dart';
import 'package:hours_control/features/presentation/themes/main_color_theme.dart';
import 'package:hours_control/shared/utils/get_employee_by_id_from_list.dart';
import 'package:hours_control/shared/utils/period_options.dart';
import 'package:intl/intl.dart';

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
    _fetchSquadMembersReports();
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

  Future<void> _fetchSquadMembersReports() async {
    final GetReportsBySquadIdUseCase getReportsBySquadId =
        GetIt.I.get<GetReportsBySquadIdUseCase>();

    try {
      List<EmployeeEntity> squadUsers = platformStore.employeeList
          .where(
            (employee) => employee.squadId == squad.id,
          )
          .toList();

      platformStore.setSquadEmployees(squadUsers);

      if (squadUsers.isNotEmpty) {
        platformStore.setIsFetchingSquadMemberHours(true);
        List<ReportEntity> squadReports = await getReportsBySquadId.call(
          params: {
            "squadId": squad.id.toString(),
            "period": _period.value.toString(),
          },
        );

        platformStore.setSquadReportsList(squadReports);
      }
    } catch (error) {
      print("Error on load squad members hours: $error");
    } finally {
      platformStore.setIsFetchingSquadMemberHours(false);
    }
  }

  List<DataRow> _buildTableData() {
    List<DataRow> dataRowList = [];
    List<ReportEntity> reports = platformStore.squadReportsList;

    for (int i = 0; i < reports.length; i++) {
      final report = reports[i];
      final EmployeeEntity? employee = getEmployeeByIdFromList(
        platformStore.employeeList,
        report.employeeId,
      );

      if (employee == null) {
        continue;
      }

      dataRowList.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(employee.name),
            ),
            DataCell(
              Text(report.description.replaceAll("\n", " ")),
            ),
            DataCell(
              Text(report.spentHours.toString()),
            ),
            DataCell(
              Text(DateFormat('dd/MM/yyyy').format(
                report.createdAt.toLocal(),
              )),
            ),
          ],
        ),
      );
    }

    return dataRowList;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Padding(
          padding: platformStore.isMobile
              ? const EdgeInsets.all(8)
              : const EdgeInsets.fromLTRB(160, 30, 160, 30),
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
                      platformStore.setSquadReportsList([]);
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
              SizedBox(height: platformStore.isMobile ? 20 : 36),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  padding: platformStore.isMobile
                      ? const EdgeInsets.symmetric(horizontal: 8, vertical: 10)
                      : const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
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
                          SizedBox(
                            height: platformStore.isMobile ? 30 : null,
                            child: SelectInputField(
                              placeholder: "Selecione o período",
                              minHeight: platformStore.isMobile ? 30 : 56,
                              style: platformStore.isMobile
                                  ? Theme.of(context).textTheme.titleMedium
                                  : null,
                              items: _getPeriods(),
                              selectedItem: _period.value,
                              onChanged: (value) {
                                setState(() {
                                  _period.value = value ?? 7;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: platformStore.isMobile ? 30 : null,
                            child: ActionButton(
                              text: "Aplicar período",
                              height: platformStore.isMobile ? 30 : null,
                              isLoading: platformStore.isFetchingSquadMemberHours,
                              isDisabled: platformStore.isFetchingSquadMemberHours,
                              onPressed: _fetchSquadMembersReports,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: platformStore.isMobile ? 20 : 32),
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
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              keyboardDismissBehavior:
                                                  ScrollViewKeyboardDismissBehavior.onDrag,
                                              physics: const AlwaysScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
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
                      SizedBox(height: platformStore.isMobile ? 20 : 32),
                      if (platformStore.squadEmployees.isNotEmpty)
                        Column(
                          children: [
                            Text(
                              "Horas totais da squad",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "27 Horas",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Theme.of(context).extension<MainColorTheme>()?.blue,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Média de horas por dia",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "3 Horas/Dia",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Theme.of(context).extension<MainColorTheme>()?.blue,
                                  ),
                            ),
                          ],
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
