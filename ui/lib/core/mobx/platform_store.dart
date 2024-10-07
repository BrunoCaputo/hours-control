import 'package:hours_control/features/domain/entities/employee_entity.dart';
import 'package:hours_control/features/domain/entities/squad_entity.dart';
import 'package:mobx/mobx.dart';

part 'platform_store.g.dart';

class PlatformStore = _PlatformStore with _$PlatformStore;

abstract class _PlatformStore with Store {
  @observable
  bool isMobile = false;

  @action
  void setIsMobile(bool mobile) => isMobile = mobile;

  @observable
  bool isFetchingSquads = false;

  @action
  void setIsFetchingSquads(bool fetching) => isFetchingSquads = fetching;

  @observable
  List<SquadEntity> squadList = [];

  @action
  void setSquadList(List<SquadEntity> squads) => squadList = squads;

  @observable
  bool isCreatingSquad = false;

  @action
  void setIsCreatingSquad(bool creating) => isCreatingSquad = creating;

  @observable
  bool isFetchingEmployees = false;

  @action
  void setIsFetchingEmployees(bool fetching) => isFetchingEmployees = fetching;

  @observable
  List<EmployeeEntity> employeeList = [];

  @action
  void setEmployeeList(List<EmployeeEntity> employees) => employeeList = employees;

  @observable
  bool isCreatingEmployee = false;

  @action
  void setIsCreatingEmployee(bool creating) => isCreatingEmployee = creating;

  @observable
  bool isCreatingReport = false;

  @action
  void setIsCreatingReport(bool creating) => isCreatingReport = creating;

  @observable
  SquadEntity? selectedSquad;

  @action
  void setSelectedSquad(SquadEntity? squad) => selectedSquad = squad;

  @observable
  List<EmployeeEntity> squadEmployees = [];

  @action
  void setSquadEmployees(List<EmployeeEntity> employees) => squadEmployees = employees;

  @observable
  bool isFetchingSquadMemberHours = false;

  @action
  void setIsFetchingSquadMemberHours(bool fetching) => isFetchingSquadMemberHours = fetching;
}
