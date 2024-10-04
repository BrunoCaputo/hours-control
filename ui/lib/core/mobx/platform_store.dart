import 'package:mobx/mobx.dart';

part 'platform_store.g.dart';

class PlatformStore = _PlatformStore with _$PlatformStore;

abstract class _PlatformStore with Store {
  @observable
  bool isMobile = false;

  @action
  void setIsMobile(bool mobile) => isMobile = mobile;
}
