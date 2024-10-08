import 'package:hours_control/core/resources/usecase.dart';
import 'package:hours_control/features/data/repositories/squad_repository_impl.dart';
import 'package:hours_control/features/domain/models/squad_member_hours.dart';
import 'package:hours_control/features/domain/repositories/squad_repository.dart';

class GetSquadMemberHoursUseCase implements UseCase<List<SquadMemberHours>, Map<String, int>?> {
  final SquadRepository _squadRepository = SquadRepositoryImpl();

  @override
  Future<List<SquadMemberHours>> call({params}) async {
    if (params == null) {
      throw Error();
    }

    return _squadRepository.getMemberHours(
      squadId: params["squadId"]!,
      period: params["period"]!,
    );
  }
}
