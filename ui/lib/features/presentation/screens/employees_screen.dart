import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/features/presentation/components/action_button.dart';
import 'package:hours_control/features/presentation/components/empty_data.dart';
import 'package:hours_control/features/presentation/screens/dialogs/create_employee_dialog.dart';
import 'package:hours_control/features/presentation/themes/main_color_theme.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late ScrollController _scrollController;

  Future<void> _fetchEmployees() async {
    try {
      platformStore.setIsFetchingEmployees(true);
      await Future.delayed(const Duration(seconds: 2));
      // TODO: FETCH SQUADS
    } catch (e) {
      print('Error fetching employees: $e');
    } finally {
      platformStore.setIsFetchingEmployees(false);
    }
  }

  List<DataRow> _buildTableData() {
    List<DataRow> dataRowList = [];

    for (int i = 0; i < platformStore.employeeList.length; i++) {
      final employee = platformStore.employeeList[i];
      dataRowList.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(employee.name),
            ),
            DataCell(
              Text(employee.estimatedHours),
            ),
            DataCell(
              Text(employee.squadId),
            ),
          ],
        ),
      );
    }

    return [];
  }

  String _getEmptyText() {
    if (platformStore.squadList.isEmpty) {
      return "Nenhuma squad cadastrada. Crie uma squad para começar.";
    }
    if (platformStore.employeeList.isEmpty) {
      return "Nenhum usuário cadastrado. Crie um usuário para começar.";
    }

    return "";
  }

  String _getButtonText() {
    if (platformStore.squadList.isEmpty) {
      return "Criar squad";
    }

    return "Criar usuário";
  }

  Widget _getDialogContent() {
    // TODO: Implement dialog content based on platformStore.squadList.isEmpty
    // if (platformStore.squadList.isEmpty) {
    //   return const CreateSquadDialog();
    // }

    return const CreateEmployeeDialog();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0);
    if (platformStore.squadList.isNotEmpty && platformStore.employeeList.isEmpty) {
      _fetchEmployees();
    }
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
              Text(
                "Lista de Usuários",
                style: platformStore.isMobile
                    ? Theme.of(context).textTheme.headlineSmall
                    : Theme.of(context).textTheme.headlineMedium,
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
                  child: platformStore.isFetchingEmployees
                      ? Center(
                          child: CircularProgressIndicator(
                            color:
                                Theme.of(context).extension<MainColorTheme>()?.blue ?? Colors.blue,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: platformStore.squadList.isEmpty ||
                                      platformStore.employeeList.isEmpty
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
                                          headingRowColor: WidgetStateProperty.resolveWith<Color>(
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
                                          dataTextStyle: Theme.of(context).textTheme.bodyMedium,
                                          columns: const <DataColumn>[
                                            DataColumn(
                                              headingRowAlignment: MainAxisAlignment.start,
                                              label: Expanded(
                                                child: Text(
                                                  'Nome',
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              headingRowAlignment: MainAxisAlignment.start,
                                              label: Expanded(
                                                child: Text(
                                                  'Horas',
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              headingRowAlignment: MainAxisAlignment.start,
                                              label: Expanded(
                                                child: Text(
                                                  'Squad ID',
                                                ),
                                              ),
                                            ),
                                          ],
                                          rows: _buildTableData(),
                                        ),
                                      ),
                                    ),
                            ),
                            ActionButton(
                              text: _getButtonText(),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _getDialogContent();
                                  },
                                );
                              },
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
