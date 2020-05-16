import 'package:city_weather/database/database_provider.dart';
import 'package:city_weather/dto/settings_dto.dart';
import 'package:rxdart/rxdart.dart';
import 'base/bloc_base.dart';

class SettingsBloc extends BlocBase {
  final databaseProvider = DatabaseProvider();
  SettingsDto settings;
  
  PublishSubject<SettingsDto> settingsFetcher = PublishSubject<SettingsDto>();

  Stream<SettingsDto> get settingsStream => settingsFetcher.stream;

  @override
  dispose() {
    settingsFetcher.close();
    super.dispose();
  }

  void loadSavedSettings() async {
    settings = await databaseProvider.getSettings();
    settingsFetcher.sink.add(settings);
  }

  void updateSettings(bool isImperial) async {
    settings = SettingsDto(isImperial: isImperial);
    settingsFetcher.sink.add(settings);
    await databaseProvider.deleteSettings();
    await databaseProvider.insertSettings(settings);
  }
}

final settingsBloc = SettingsBloc();