import 'package:flutter_kevy_admin/models/producto.dart';
import 'package:flutter_kevy_admin/storage/db_init.dart';
import 'package:sqflite/sqflite.dart';

class ProductoController {
    // Patrón Singleton: Solo una instancia en toda la app
  static final ProductoController instance = ProductoController._init();
  Future<Database> get database async => await DatabaseManager.instance.database;

  ProductoController._init();

  Future<int> insertProducto(Producto producto) async {
    final db = await instance.database;
    return await db.insert('productos', producto.toMap());
  }

  Future<List<Producto>> getProductos({
    bool mostrar_habilitados = true, 
    bool mostrar_deshabilitados = false}) async {

    List estatusBuscar = [];

    if(mostrar_habilitados){
      estatusBuscar.add(1);
    }

    if(mostrar_deshabilitados){
      estatusBuscar.add(0);
    }
    // Creamos los signos de interrogación dinámicamente según cuántos estatus haya
    // Si hay 2, será "?, ?", si hay 1, será "?"
    String placeholders = estatusBuscar.map((e) => '?').join(', ');


    final db = await database;
    final result = await db.query(
      'productos',
      where: "estatus IN ($placeholders)", 
      whereArgs: estatusBuscar
    );
    print("${result}");
    return result.map( (json) => 
      Producto.fromMap(json)).toList();
  }

  Future<int> deshabilitarProducto(int id)async {
    final db = await instance.database;

    // 1. Definimos los valores a cambiar en un Mapa
    final valores = {
      'estatus': 0
    };

    final result = await db.update(
      'productos', 
      valores,
      where: 'id = ?',
      whereArgs: [id], // El valor que reemplaza al '?'
    );

    return result;
  }

  Future<int> habilitarProducto(int id)async {
    final db = await instance.database;

    // 1. Definimos los valores a cambiar en un Mapa
    final valores = {
      'estatus': 1
    };

    final result = await db.update(
      'productos', 
      valores,
      where: 'id = ?',
      whereArgs: [id], // El valor que reemplaza al '?'
    );

    return result;
  }
  
}