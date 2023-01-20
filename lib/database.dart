import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final String tablename = 'gpa';
final String columnId = '_id';
final String columnName = 'name';
final String columnGpa = 'gpa';

class name_gpa
{
  int? id;
  String? name;
  double? gpa;

  name_gpa({this.name,this.gpa});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnGpa:gpa,
    };
    return map;
  }

  name_gpa.fromMap(Map<String, dynamic> map)
  {
    id = map[columnId] as int;
    name = map[columnName] as String;
    gpa = map[columnGpa] as double;
  }
}
class dbhelper
{
  dbhelper._privateConstructor();
  static final dbhelper instance=dbhelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async =>_database ??= await _initdatabase();

  Future<Database> _initdatabase() async
  {
    Directory db_loc= await getApplicationDocumentsDirectory();
    String path =join(db_loc.path,'gpa.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db,int v) async
  {
    await db.execute('''
    CREATE TABLE $tablename(
    $columnId int,
    $columnName TEXT,
    $columnGpa REAL 
    ) 
    ''');
  }
  Future<name_gpa> add(name_gpa ng) async
  {
    Database db=await instance.database;
    await db.insert('gpa',ng.toMap());
    return ng;
  }
  Future<List<name_gpa>> get() async
  {
    Database db=await instance.database;
    var ng = await db.query('gpa', columns: [columnName, columnGpa]);
    List<name_gpa>ngl=ng.isNotEmpty? ng.map((c) => name_gpa.fromMap(c)).toList():[];
    return ngl;
  }
}