import 'package:hours_control/core/resources/usecase.dart';
import 'package:hours_control/features/data/repositories/squad_repository_impl.dart';
import 'package:hours_control/features/domain/repositories/squad_repository.dart';

class GetSquadAverageHoursUseCase implements UseCase<double, Map<String, int>?> {
  final SquadRepository _squadRepository = SquadRepositoryImpl();

  @override
  Future<double> call({params}) async {
    if (params == null) {
      throw Error();
    }

    return _squadRepository.getSquadAverageHours(
      squadId: params["squadId"]!,
      period: params["period"]!,
    );
  }
}
