import 'package:hours_control/core/resources/usecase.dart';
import 'package:hours_control/features/data/repositories/report_repository_impl.dart';
import 'package:hours_control/features/domain/entities/report_entity.dart';
import 'package:hours_control/features/domain/repositories/report_repository.dart';

class GetReportsBySquadIdUseCase implements UseCase<List<ReportEntity>, Map<String, String>?> {
  final ReportRepository _reportRepository = ReportRepositoryImpl();

  @override
  Future<List<ReportEntity>> call({params}) async {
    if (params == null) {
      throw Error();
    }

    return _reportRepository.getReportsBySquadId(
      squadId: int.parse(params["squadId"]!),
      period: int.parse(
        params["period"]!,
      ),
    );
  }
}
