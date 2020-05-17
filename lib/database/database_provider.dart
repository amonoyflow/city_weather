import 'package:city_weather/dto/settings_dto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  final table = "settings";
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
		var directory = await getApplicationDocumentsDirectory();
		var path = directory.path + 'city_weather.db';
		return await openDatabase(path, version: 1, 
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $table ("
          "is_imperial INTEGER"
          ")"
        );
      }
    );
	}

  Future<SettingsDto> getSettings() async {
    var db =  await this.database;
    var settings = await db.query(table);
    if (settings.isEmpty) {
      return SettingsDto(isImperial: false);
    }
    return SettingsDto.fromMapObject(settings.first);
  }

  Future<int> insertSettings(SettingsDto settings) async {
		var db = await this.database;
		var result = await db.insert(table, settings.toMap());
		return result;
	}

  Future<int> deleteSettings() async {
		var db = await this.database;
		var result = await db.rawDelete("DELETE FROM $table");
		return result;
	}
}