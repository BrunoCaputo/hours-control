import 'package:hours_control/features/domain/entities/report_entity.dart';

abstract class ReportRepository {
  Future<ReportEntity> createReport({
    required String description,
    required int employeeId,
    required int spentHours,
  });

  Future<List<ReportEntity>> getReportsBySquadId({
    required int squadId,
    required int period,
  });
}
