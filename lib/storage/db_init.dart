import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/producto.dart'; // Ajusta la ruta a tu modelo

class DatabaseManager {
  // Patrón Singleton: Solo una instancia en toda la app
  static final DatabaseManager instance = DatabaseManager._init();
  static Database? _database;

  DatabaseManager._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('kevy_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 4,
      onCreate: _createDB,
      onUpgrade: _onUpgrade
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE productos(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        nombre TEXT NOT NULL, 
        existencias INTEGER NOT NULL, 
        precio REAL NOT NULL
      )
    ''');
  }

  // --- OPERACIONES CRUD ---

  // Future<int> insertProducto(Producto producto) async {
  //   final db = await instance.database;
  //   return await db.insert('productos', producto.toMap());
  // }

  // Future<List<Producto>> getProductos() async {
  //   final db = await instance.database;
  //   final result = await db.query('productos');
  //   return result.map((json) => Producto.fromMap(json)).toList();
  // }

  Future<int> borrarProducto(int id_producto)async {
    final db = await instance.database;

    // 1. Definimos los valores a cambiar en un Mapa
    final valores = {
      'estatus': 0
    };

    final result = await db.update(
      'productos', 
      valores,
      where: 'id = ?',
      whereArgs: [id_producto], // El valor que reemplaza al '?'
    );

    return result;
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion)async{
    if (oldVersion < 4) {
      // Aquí pones el comando SQL para agregar SOLO la nueva columna
      await db.execute('ALTER TABLE productos ADD COLUMN estatus INTEGER NOT NULL DEFAULT "0"');
      print("¡Tabla productos actualizada a la versión $newVersion!");
    }
  }

}