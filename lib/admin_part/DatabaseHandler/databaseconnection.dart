// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class DatabaseConnection {
//   Future<Database> setDatabase() async {
//     var directory = await getApplicationDocumentsDirectory();
//     var path = join(directory.path, 'policesystem'); //database name
//     var database = await openDatabase(path,
//         version: 1, onCreate: _createDatabase); //create db
//     return database;
//   }

//   Future<void> _createDatabase(Database database, int version) async {
//     //Create table conn to database
//     String sql =
//         "CREATE TABLE admin (full_name TEXT, username TEXT, password TEXT, address TEXT, phone_num INTEGER);";
//     await database.execute(sql);
//   }
// }
