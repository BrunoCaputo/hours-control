import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/features/domain/entities/squad_entity.dart';
import 'package:hours_control/features/domain/usecases/fetch_squads.dart';
import 'package:hours_control/features/presentation/components/action_button.dart';
import 'package:hours_control/features/presentation/components/empty_data.dart';
import 'package:hours_control/features/presentation/components/icon_button.dart';
import 'package:hours_control/features/presentation/screens/dialogs/create_squad_dialog.dart';
import 'package:hours_control/features/presentation/themes/main_color_theme.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class SquadsScreen extends StatefulWidget {
  const SquadsScreen({super.key});

  @override
  State<SquadsScreen> createState() => _SquadsScreenState();
}

class _SquadsScreenState extends State<SquadsScreen> {
  late ScrollController _scrollController;

  Future<void> _fetchSquads() async {
    final FetchSquadsUseCase fetchSquadsUseCase = GetIt.I.get<FetchSquadsUseCase>();

    try {
      platformStore.setIsFetchingSquads(true);
      List<SquadEntity> squads = await fetchSquadsUseCase.call();
      print("SQUADS: ${squads.toString()}");
      platformStore.setSquadList(squads);
    } catch (e) {
      print('Error fetching squads: $e');
    } finally {
      platformStore.setIsFetchingSquads(false);
    }
  }

  List<DataRow> _buildTableData() {
    List<DataRow> dataRowList = [];

    for (int i = 0; i < platformStore.squadList.length; i++) {
      final squad = platformStore.squadList[i];
      dataRowList.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(squad.id.toString()),
            ),
            DataCell(
              Text(squad.name),
            ),
            DataCell(
              Align(
                alignment: Alignment.centerRight,
                child: platformStore.isMobile
                    ? CustomIconButton(
                        onPressed: () {
                          print("CLICK");
                        },
                        tooltip: "Visitar squad",
                        icon: const Icon(
                          Icons.group,
                          color: Colors.white,
                        ),
                      )
                    : const ActionButton(text: "Visitar squad"),
              ),
            ),
          ],
        ),
      );
    }

    return dataRowList;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0);
    if (platformStore.squadList.isEmpty) {
      _fetchSquads();
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
                "Lista de Squads",
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
                  child: platformStore.isFetchingSquads
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
                              child: platformStore.squadList.isEmpty
                                  ? const Center(
                                      child: EmptyData(
                                        emptyText:
                                            "Nenhuma squad cadastrada. Crie uma squad para começar.",
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
                                                  'ID',
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              headingRowAlignment: MainAxisAlignment.start,
                                              label: Expanded(
                                                child: Text(
                                                  'Nome',
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              headingRowAlignment: MainAxisAlignment.end,
                                              label: Text(''),
                                            ),
                                          ],
                                          rows: _buildTableData(),
                                        ),
                                      ),
                                    ),
                            ),
                            ActionButton(
                              text: "Criar squad",
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CreateSquadDialog();
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
