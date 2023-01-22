import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final String tablename = 'gpa';
final String columnId = 'id';
final String columnName = 'name';
final String columnGpa = 'gpa';
final String columnCredit='credit';
class name_gpa
{
  int? id;
  String? name;
  double? gpa;
  int? credit;
  name_gpa(String name,double gpa,int credit)
  {
    this.name=name;
    this.gpa=gpa;
    this.credit=credit;
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnGpa:gpa,
      columnCredit:credit,
    };
    return map;
  }

  name_gpa.fromMap(Map<String, dynamic> map)
  {
    id = map[columnId] as int;
    name = map[columnName] as String;
    gpa = map[columnGpa] as double;
    credit=map[columnCredit] as int;
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
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnName TEXT,
    $columnGpa REAL,
    $columnCredit int 
    ) 
    ''');
  }
  Future<name_gpa> add(name_gpa ng) async
  {
    Database db=await instance.database;
    await db.insert('gpa',ng.toMap());
    return ng;
  }
  static Future<List<Map>> getdata() async
  {
    Database db=await instance.database;
    List<Map>res=await db.query('gpa', columns: [columnId,columnName, columnGpa,columnCredit]);
    return res;
  }
  static Future delete(int id) async
  {
    Database db=await instance.database;
    await db.rawQuery('delete from gpa where id=$id');
  }
  static void update(int id,int c,double g,String name) async
  {
    Database db=await instance.database;
    await db.rawQuery('update gpa set credit=$c where id=$id');
    await db.rawQuery('update gpa set gpa=$g where id=$id');
    await db.rawQuery('update gpa set name=$name where id=$id');
  }
}