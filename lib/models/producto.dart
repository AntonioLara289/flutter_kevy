class Producto{

  final int? id;
  final String nombre;
  final int existencias;
  final double precio;
  final int? estatus;

  const Producto({
    this.id, 
    required this.nombre, 
    required this.existencias, 
    required this.precio,
    this.estatus
  });

// Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {'id': id, 'nombre': nombre, 'existencias': existencias, 'precio': precio, 'estatus': estatus};
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Producto{id: $id, nombre: $nombre, existencias: $existencias, precio: $precio, estatus $estatus}';
  }

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      existencias: map['existencias'] as int,
      precio: (map['precio'] as num).toDouble(), // num maneja int o double de forma segura
      estatus: map['estatus'] as int
    );
  }
}