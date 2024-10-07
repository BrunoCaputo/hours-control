import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hours_control/config/server_url.dart';
import 'package:hours_control/features/domain/entities/squad_entity.dart';

abstract class SquadDataSource {
  Future<List<SquadEntity>> fetchSquads();

  Future<SquadEntity> createSquad({required String name});
}

class SquadDataSourceImpl implements SquadDataSource {
  final Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<List<SquadEntity>> fetchSquads() async {
    Uri url = Uri.parse("$serverApiBaseUrl/squad");

    try {
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<SquadEntity> result = List.from(data['squads'] ?? [])
            .map(
              (squad) => SquadEntity.fromJson(squad),
            )
            .toList();
        return result;
      } else {
        throw Exception('Failed to fetch squads');
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<SquadEntity> createSquad({required String name}) async {
    Uri url = Uri.parse("$serverApiBaseUrl/squad");

    try {
      var response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({"name": name}),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("DATA: ${data.toString()}");
        SquadEntity result = SquadEntity.fromJson(data);
        return result;
      } else {
        throw Exception('Failed to create squad');
      }
    } catch (error) {
      rethrow;
    }
  }
}
