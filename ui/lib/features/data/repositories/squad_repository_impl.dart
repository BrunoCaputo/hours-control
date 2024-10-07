import 'package:hours_control/features/data/data_source/remote/squad_data_source.dart';
import 'package:hours_control/features/domain/entities/squad_entity.dart';
import 'package:hours_control/features/domain/models/squad_member_hours.dart';
import 'package:hours_control/features/domain/repositories/squad_repository.dart';

class SquadRepositoryImpl implements SquadRepository {
  final SquadDataSource _squadDataSource = SquadDataSourceImpl();

  @override
  Future<List<SquadEntity>> fetchSquads() async {
    try {
      var squads = await _squadDataSource.fetchSquads();
      return squads;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<SquadEntity> createSquad({required String name}) async {
    try {
      SquadEntity newSquad = await _squadDataSource.createSquad(name: name);
      return newSquad;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<SquadMemberHours>> getMemberHours({
    required int squadId,
    required int period,
  }) async {
    try {
      Map<String, Map<String, int>> memberHours = await _squadDataSource.getMemberHours(
        squadId: squadId,
        period: period,
      );

      List<Map<String, dynamic>> flatList = memberHours.entries.map((entry) {
        return {
          'employeeId': entry.key,
          'spentHours': entry.value['spentHours'],
        };
      }).toList();

      return flatList.map((map) => SquadMemberHours.fromJson(map)).toList();
    } catch (error) {
      rethrow;
    }
  }
}
