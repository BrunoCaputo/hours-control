import 'package:collection/collection.dart';
import 'package:hours_control/features/domain/entities/employee_entity.dart';

EmployeeEntity? getEmployeeByIdFromList(List<EmployeeEntity> employeeList, int employeeId) {
  return employeeList.firstWhereOrNull((employee) => employee.id == employeeId);
}
