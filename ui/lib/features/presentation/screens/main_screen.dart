import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/features/domain/entities/employee_entity.dart';
import 'package:hours_control/features/domain/entities/squad_entity.dart';
import 'package:hours_control/features/domain/usecases/fetch_employees.dart';
import 'package:hours_control/features/domain/usecases/fetch_squads.dart';
import 'package:hours_control/features/presentation/components/action_button.dart';
import 'package:hours_control/features/presentation/screens/dialogs/new_report_dialog.dart';
import 'package:hours_control/features/presentation/screens/employees_screen.dart';
import 'package:hours_control/features/presentation/screens/squad_details_screen.dart';
import 'package:hours_control/features/presentation/screens/squads_screen.dart';
import 'package:hours_control/features/presentation/themes/grayscale_color_theme.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);

    Future.wait([
      _fetchSquads(),
      _fetchEmployees(),
    ]);
  }

  Future<void> _fetchEmployees() async {
    final FetchEmployeesUseCase fetchEmployeesUseCase = GetIt.I.get<FetchEmployeesUseCase>();

    try {
      platformStore.setIsFetchingEmployees(true);
      List<EmployeeEntity> employees = await fetchEmployeesUseCase.call();
      platformStore.setEmployeeList(employees);
    } catch (e) {
      print('Error fetching employees: $e');
    } finally {
      platformStore.setIsFetchingEmployees(false);
    }
  }

  Future<void> _fetchSquads() async {
    final FetchSquadsUseCase fetchSquadsUseCase = GetIt.I.get<FetchSquadsUseCase>();

    try {
      platformStore.setIsFetchingSquads(true);
      List<SquadEntity> squads = await fetchSquadsUseCase.call();
      platformStore.setSquadList(squads);
    } catch (e) {
      print('Error fetching squads: $e');
    } finally {
      platformStore.setIsFetchingSquads(false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 110,
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: platformStore.isMobile ? 0 : 160),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/logo.svg",
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "Interface para lançamento de horas",
                        style: (platformStore.isMobile
                                ? Theme.of(context).textTheme.bodySmall
                                : Theme.of(context).textTheme.bodyMedium)
                            ?.copyWith(
                          color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray3,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "PD Hours",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      ActionButton(
                        text: "Lançar horas",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const NewReportDialog();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: "Squads",
                ),
                Tab(
                  text: "Usuários",
                ),
              ],
            ),
          ),
          body: Container(
            color: Theme.of(context).extension<GrayscaleColorTheme>()?.grayBody,
            child: TabBarView(
              controller: _tabController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                platformStore.selectedSquad != null
                    ? const SquadDetailsScreen()
                    : const SquadsScreen(),
                const EmployeesScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
