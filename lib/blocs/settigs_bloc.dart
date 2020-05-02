import 'package:rxdart/rxdart.dart';

import 'base/bloc_base.dart';

class SettingsBloc extends BlocBase {
  bool isImperialSystem = false;

  PublishSubject<bool> unitFetcher = PublishSubject<bool>();

  Stream<bool> get currentUnitStream => unitFetcher.stream;

  bool isUnitImperial() {
    return isImperialSystem;
  }

  void onUnitChanged(bool isImperial) {
    isImperialSystem = isImperial;
    unitFetcher.sink.add(isImperialSystem);
  }

  @override
  dispose() {
    unitFetcher.close();
    super.dispose();
  }
}

final settingsBloc = SettingsBloc();