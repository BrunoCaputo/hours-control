import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hours_control/config/server_url.dart';
import 'package:hours_control/features/domain/entities/report_entity.dart';

abstract class ReportDataSource {
  Future<ReportEntity> createReport({
    required String description,
    required int employeeId,
    required int spentHours,
  });
}

class ReportDataSourceImpl implements ReportDataSource {
  final Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<ReportEntity> createReport({
    required String description,
    required int employeeId,
    required int spentHours,
  }) async {
    Uri url = Uri.parse("$serverApiBaseUrl/report");

    try {
      var response = await http.post(
        url,
        headers: header,
        body: jsonEncode({
          "description": description,
          "employee_id": employeeId,
          "spent_hours": spentHours,
        }),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        ReportEntity result = ReportEntity.fromJson(data);
        return result;
      } else {
        throw Exception('Failed to create report');
      }
    } catch (error) {
      rethrow;
    }
  }
}
