import 'package:hours_control/core/resources/usecase.dart';
import 'package:hours_control/features/data/repositories/squad_repository_impl.dart';
import 'package:hours_control/features/domain/entities/squad_entity.dart';
import 'package:hours_control/features/domain/repositories/squad_repository.dart';

class FetchSquadsUseCase implements UseCase<List<SquadEntity>, void> {
  final SquadRepository _squadRepository = SquadRepositoryImpl();

  @override
  Future<List<SquadEntity>> call({params}) async {
    return _squadRepository.fetchSquads();
  }
}
