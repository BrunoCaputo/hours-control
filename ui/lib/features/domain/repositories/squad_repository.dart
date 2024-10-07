import 'package:hours_control/features/domain/entities/squad_entity.dart';

abstract class SquadRepository {
  Future<List<SquadEntity>> fetchSquads();
}
