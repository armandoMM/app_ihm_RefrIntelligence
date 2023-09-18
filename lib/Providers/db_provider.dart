import 'package:app_ihm/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Reminders.db');
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Verduras(
          idVerdura INTEGER PRIMARY KEY,
          nombre TEXT)
        ''');
      await db.execute('''
        CREATE TABLE Historicos(
          idHistorico INTEGER PRIMARY KEY,
          fechaIngreso TEXT, 
          fechaCaducidad TEXT, 
          cantidad TEXT, 
          idVerdura INTEGER REFERENCES Verduras)
      ''');
      await db.execute('CREATE INDEX verduraIndex ON Historicos(idVerdura)');
      await db.rawInsert('''
        INSERT INTO Verduras(nombre) VALUES('Tomate'),('Jitomate'),('Chile'),('Cebolla'),('Zanahoria'),('Papa'),('Calabaza')
      ''');
    });
  }

  Future<int?> newMetricRow(Arguments args) async {
    final fechaIngreso = args.fechaIngreso,
        fechaCaducidad = args.fechaCaducidad,
        cantidad = args.cantidad,
        idVerdura = args.idVerdura;
    final db = await database;
    final res = await db?.rawInsert('''
      INSERT INTO Historicos(fechaIngreso,fechaCaducidad,cantidad,idVerdura)
      VALUES(?,?,?,?)''', [fechaIngreso, fechaCaducidad, cantidad, idVerdura]);
    return res;
  }

  Future<List<Arguments>> getAllHistoricos() async {
    final db = await database;
    final res = await db?.query('Historicos');
    return res!.map((a) => Arguments.fromJson(a)).toList();
  }

  Future<int> newHistoricos(Arguments args) async {
    final db = await database;
    final res = await db!.insert('Historicos', args.toJson());
    return res;
  }

  Future<List<ArgsVerduras>> getAllVerduras() async {
    final db = await database;
    final res = await db?.query('Verduras');
    return res!.map((a) => ArgsVerduras.fromJson(a)).toList();
  }

  Future<List<ArgsVerduras>> getVerdurasID(String name) async {
    final db = await database;
    final res = await db?.rawQuery('SELECT * FROM Verduras WHERE nombre=?', [name]);
    return res!.map((a) => ArgsVerduras.fromJson(a)).toList();
  }

  Future<List<Arguments>> getUltimateHistoricos() async {
    final db = await database;
    final res = await db?.query('Historicos', orderBy: 'fechaCaducidad');
    return res!.map((a) => Arguments.fromJson(a)).toList();
  }

  Future<void> deleteHistorico(int id) async {
    final db = await database;
    await db?.delete('Historicos', where: 'idHistorico=?', whereArgs: [id]);
  }
}
