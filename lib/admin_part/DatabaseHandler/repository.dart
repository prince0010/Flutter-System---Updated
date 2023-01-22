// //Connection sa DATABASE Og sa functions sa pag insert add delete read update sa database
// import 'package:policesystem/admin_part/DatabaseHandler/databaseconnection.dart';
// import 'package:sqflite/sqflite.dart';

// class Repository {
//   late DatabaseConnection _databaseConnection;

//   Repository() {
//     _databaseConnection = DatabaseConnection();
//   }
//   static Database? _database;
//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     } else {
//       _database = await _databaseConnection.setDatabase();
//       return _database;
//     }
//   }

//   //Insert Data to Admin Table

//   insertData(table, data) async {
//     var connection = await database; //gikan sadatabase connection dart
//     return await connection?.insert(table, data);
//   }

//   //Read All Record from admin table
//   readData(table) async {
//     var connection = await database;
//     return await connection?.query(table);
//   }
// }
