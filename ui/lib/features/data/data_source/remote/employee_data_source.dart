import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hours_control/config/server_url.dart';
import 'package:hours_control/features/domain/entities/employee_entity.dart';

abstract class EmployeeDataSource {
  Future<List<EmployeeEntity>> fetchEmployees();

  Future<EmployeeEntity> createEmployee({
    required String name,
    required int estimatedHours,
    required int squadId,
  });
}

class EmployeeDataSourceImpl implements EmployeeDataSource {
  final Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<List<EmployeeEntity>> fetchEmployees() async {
    Uri url = Uri.parse("$serverApiBaseUrl/employee");

    try {
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<EmployeeEntity> result = List.from(data['employees'] ?? [])
            .map(
              (employee) => EmployeeEntity.fromJson(employee),
            )
            .toList();
        return result;
      } else {
        throw Exception('Failed to fetch employees');
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<EmployeeEntity> createEmployee(
      {required String name, required int estimatedHours, required int squadId}) {
    // TODO: implement createEmployee
    throw UnimplementedError();
  }
}
