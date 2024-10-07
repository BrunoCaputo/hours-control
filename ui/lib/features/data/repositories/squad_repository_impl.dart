import 'package:hours_control/features/data/data_source/remote/squad_data_source.dart';
import 'package:hours_control/features/domain/entities/squad_entity.dart';
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
}
