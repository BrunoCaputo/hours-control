import 'package:hours_control/features/domain/entities/employee_entity.dart';

abstract class EmployeeRepository {
  Future<List<EmployeeEntity>> fetchEmployees();

  Future<EmployeeEntity> createEmployee({
    required String name,
    required int estimatedHours,
    required int squadId,
  });
}
