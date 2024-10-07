import 'package:hours_control/core/resources/usecase.dart';
import 'package:hours_control/features/data/repositories/report_repository_impl.dart';
import 'package:hours_control/features/domain/entities/report_entity.dart';
import 'package:hours_control/features/domain/repositories/report_repository.dart';

class CreateReportUseCase implements UseCase<ReportEntity, Map<String, String>?> {
  final ReportRepository _reportRepository = ReportRepositoryImpl();

  @override
  Future<ReportEntity> call({params}) async {
    if (params == null) {
      throw Error();
    }

    return _reportRepository.createReport(
      description: params["description"]!,
      employeeId: int.parse(params["employeeId"]!),
      spentHours: int.parse(params["spentHours"]!),
    );
  }
}
