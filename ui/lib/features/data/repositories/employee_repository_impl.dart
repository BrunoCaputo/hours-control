import 'package:hours_control/features/data/data_source/remote/employee_data_source.dart';
import 'package:hours_control/features/domain/entities/employee_entity.dart';
import 'package:hours_control/features/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeDataSource _employeeDataSource = EmployeeDataSourceImpl();

  @override
  Future<List<EmployeeEntity>> fetchEmployees() async {
    try {
      var employees = await _employeeDataSource.fetchEmployees();
      return employees;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<EmployeeEntity> createEmployee({
    required String name,
    required int estimatedHours,
    required int squadId,
  }) {
    // TODO: implement createEmployee
    throw UnimplementedError();
  }
}
