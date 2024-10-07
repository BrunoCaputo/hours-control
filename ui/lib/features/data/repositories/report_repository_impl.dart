import 'package:hours_control/features/data/data_source/remote/report_data_source.dart';
import 'package:hours_control/features/domain/entities/report_entity.dart';
import 'package:hours_control/features/domain/repositories/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportDataSource _reportDataSource = ReportDataSourceImpl();

  @override
  Future<ReportEntity> createReport({
    required String description,
    required int employeeId,
    required int spentHours,
  }) async {
    try {
      ReportEntity newReport = await _reportDataSource.createReport(
        description: description,
        employeeId: employeeId,
        spentHours: spentHours,
      );
      return newReport;
    } catch (error) {
      rethrow;
    }
  }
}
