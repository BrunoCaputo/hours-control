import 'package:mobx/mobx.dart';

part 'platform_store.g.dart';

class PlatformStore = _PlatformStore with _$PlatformStore;

abstract class _PlatformStore with Store {
  @observable
  bool isMobile = false;

  @action
  void setIsMobile(bool mobile) => isMobile = mobile;

  @observable
  bool isFetchingSquads = false;

  @action
  void setIsFetchingSquads(bool fetching) => isFetchingSquads = fetching;

  @observable
  List<dynamic> squadList = [];

  @action
  void setSquadList(List<dynamic> squads) => squadList = squads;

  @observable
  bool isCreatingSquad = false;

  @action
  void setIsCreatingSquad(bool creating) => isCreatingSquad = creating;
}
