import 'package:hours_control/core/resources/usecase.dart';
import 'package:hours_control/features/data/repositories/squad_repository_impl.dart';
import 'package:hours_control/features/domain/entities/squad_entity.dart';
import 'package:hours_control/features/domain/repositories/squad_repository.dart';

class CreateSquadUseCase implements UseCase<SquadEntity, Map<String, String>?> {
  final SquadRepository _squadRepository = SquadRepositoryImpl();

  @override
  Future<SquadEntity> call({params}) async {
    if(params == null) {
      throw Error();
    }

    return _squadRepository.createSquad(name: params["name"]!);
  }
}
