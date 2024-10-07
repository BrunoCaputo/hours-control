import 'package:hours_control/core/resources/usecase.dart';
import 'package:hours_control/features/data/repositories/employee_repository_impl.dart';
import 'package:hours_control/features/domain/entities/employee_entity.dart';
import 'package:hours_control/features/domain/repositories/employee_repository.dart';

class FetchEmployeesUseCase implements UseCase<List<EmployeeEntity>, void> {
  final EmployeeRepository _employeeRepository = EmployeeRepositoryImpl();

  @override
  Future<List<EmployeeEntity>> call({params}) async {
    return _employeeRepository.fetchEmployees();
  }
}
