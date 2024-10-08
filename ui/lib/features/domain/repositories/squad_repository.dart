import 'package:hours_control/features/domain/entities/squad_entity.dart';
import 'package:hours_control/features/domain/models/squad_member_hours.dart';

abstract class SquadRepository {
  Future<List<SquadEntity>> fetchSquads();

  Future<SquadEntity> createSquad({required String name});

  Future<List<SquadMemberHours>> getMemberHours({
    required int squadId,
    required int period,
  });

  Future<int> getSquadTotalSpentHours({
    required int squadId,
    required int period,
  });

  Future<double> getSquadAverageHours({
    required int squadId,
    required int period,
  });
}
