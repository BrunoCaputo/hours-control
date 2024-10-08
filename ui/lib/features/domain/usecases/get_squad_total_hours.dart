import 'package:hours_control/core/resources/usecase.dart';
import 'package:hours_control/features/data/repositories/squad_repository_impl.dart';
import 'package:hours_control/features/domain/repositories/squad_repository.dart';

class GetSquadTotalHoursUseCase implements UseCase<int, Map<String, int>?> {
  final SquadRepository _squadRepository = SquadRepositoryImpl();

  @override
  Future<int> call({params}) async {
    if (params == null) {
      throw Error();
    }

    return _squadRepository.getSquadTotalSpentHours(
      squadId: params["squadId"]!,
      period: params["period"]!,
    );
  }
}
