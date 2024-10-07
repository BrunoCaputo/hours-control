import 'package:hours_control/core/resources/usecase.dart';
import 'package:hours_control/features/data/repositories/employee_repository_impl.dart';
import 'package:hours_control/features/domain/entities/employee_entity.dart';
import 'package:hours_control/features/domain/repositories/employee_repository.dart';

class CreateEmployeeUseCase implements UseCase<EmployeeEntity, Map<String, String>?> {
  final EmployeeRepository _employeRepository = EmployeeRepositoryImpl();

  @override
  Future<EmployeeEntity> call({params}) async {
    if (params == null) {
      throw Error();
    }

    return _employeRepository.createEmployee(
      name: params["name"]!,
      estimatedHours: int.parse(params["estimatedHours"]!),
      squadId: int.parse(params["squadId"]!),
    );
  }
}
