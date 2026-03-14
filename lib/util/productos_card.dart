import 'package:flutter/material.dart';
import 'package:flutter_kevy_admin/models/producto.dart';
import 'package:flutter_kevy_admin/storage/producto_controller.dart';
import 'package:flutter_kevy_admin/util/producto_card.dart';

class ProductosCard extends StatefulWidget {

  final bool mostrar_habilitados;
  final bool mostrar_deshabilitados;

  const ProductosCard({
    super.key, 
    this.mostrar_deshabilitados = false,
    this.mostrar_habilitados = true
  });

  @override
  State<ProductosCard> createState() => ProductosCardState();
}

class ProductosCardState extends State<ProductosCard> {
  // 1. Guardamos el Future en una variable persistente
  late Future<List<Producto>> _productosFuture;

  @override
  void initState() {
    super.initState();
    // 2. Solo se llama UNA VEZ al iniciar el widget
    cargarDatos(); // Inicializamos
  }

  // ESTA FUNCIÓN ES LA CLAVE
  void cargarDatos() { // Asegúrate de que NO tenga guion bajo
    setState(() {
      print('mostrar_habilitados: ${widget.mostrar_habilitados}');
      print('mostrar_deshabilitados: ${widget.mostrar_deshabilitados}');

      _productosFuture = ProductoController.instance.getProductos(
        mostrar_habilitados: widget.mostrar_habilitados, 
        mostrar_deshabilitados: widget.mostrar_deshabilitados
      );
    });
  }

  void didUpdateWidget(ProductosCard oldWidget){
    super.didUpdateWidget(oldWidget);

    if(
      oldWidget.mostrar_deshabilitados != widget.mostrar_deshabilitados ||
      oldWidget.mostrar_habilitados != widget.mostrar_habilitados
    ){
      cargarDatos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<List<Producto>>(
        future:
            _productosFuture, // 3. Usamos la variable, NO la función directo
        builder: (context, snapshot) {
          // ... (el resto de tu lógica de snapshot igual que antes)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.blueAccent,));
          }

          final productos = snapshot.data ?? [];
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns
              crossAxisSpacing: 10,
              // mainAxisSpacing: 10,
              // childAspectRatio: 2.0, // Square items
              childAspectRatio: 0.8, // <--- Juega con este valor (ej. 0.7 o 0.6) para dar más altura
            ),
            itemCount: productos.length,
            itemBuilder: (context, index) => 
            ProductoCard(producto: productos[index], onRefresh: cargarDatos)
          );
        },
      ),
    );
  }

  String verificarNombre(String? nombre) {
    if (nombre == null || nombre.isEmpty) {
      return "Sin nombre";
    }

    return nombre;
  }

  String verificarExistencias(int? existencias){
    if(existencias == null){
      return "Sin valor";
    }

    return existencias.toString();
  }
}


/*
Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blueAccent.withAlpha(50),
                onTap: () {
                  debugPrint(verificarNombre(productos[index].nombre));
                },
                child: SizedBox(
                  width: 50,
                  height: 80,
                  child: 
                    Column(
                      mainAxisAlignment: .start,
                      children: [
                        Text(
                          productos[index].nombre, 
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                        ),
                        Text(
                          "Existencias: ${productos[index].existencias}",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${productos[index].precio}',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ]
                  )
                ),
              ),
            ),*/