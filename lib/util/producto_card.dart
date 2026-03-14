import 'package:flutter/material.dart';
import 'package:flutter_kevy_admin/models/producto.dart';
import 'package:flutter_kevy_admin/screens/dialogs/dialog_editar_producto.dart';
import 'package:flutter_kevy_admin/screens/dialogs/dialog_question.dart';
import 'package:flutter_kevy_admin/storage/producto_controller.dart';
import 'package:flutter_kevy_admin/util/productos_card.dart';
import 'package:flutter_kevy_admin/util/snack_bar.dart';

class ProductoCard extends StatefulWidget {
  final Producto producto;
  final VoidCallback onRefresh; // <--- Agregamos esto

  const ProductoCard({
    super.key,
    required this.producto,
    required this.onRefresh,
  });

  @override
  State<ProductoCard> createState() => _ProductoCardState();
}

class _ProductoCardState extends State<ProductoCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      clipBehavior: Clip.hardEdge,
      color: widget.producto.estatus == 1 ? Color.fromARGB(255, 148, 207, 255) : Color.fromARGB(255, 243, 155, 128),
      child: InkWell(
        splashColor: Colors.blueAccent.withAlpha(50),
        onTap: () async {
          // debugPrint("Texto");
          final resultado = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                DialogEditarProducto(producto: widget.producto),
          );
        },
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: .start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  verificarNombre(widget.producto.nombre),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, height: 1.3),
                  textAlign: .center,
                  maxLines: 2,
                ),
                Text(
                  "Existencias: ${verificarExistencias(widget.producto.existencias)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: .center,
                  maxLines: 1,
                ),
                Text(
                  '\$${verificarPrecio(widget.producto.precio)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: .center,
                  maxLines: 1,
                ),

                if (widget.producto.estatus == 1)
                  ElevatedButton(
                    onPressed: () async {

                      final abrirDialogQuestion = await showDialog(
                        barrierDismissible: false,
                        context: context, 
                        builder:  (BuildContext context) => DialogQuestion(
                          titulo: "Borrar Producto",
                          mensaje: "¿Desea borrar el producto ${widget.producto.nombre}?",
                        )
                      );
                      return ;
                      final resultado = await deshabilitarProducto(
                        widget.producto.id,
                      );

                      if (resultado == 1) {
                        SnackBarNotification.mostrarMensaje(
                          context,
                          mensaje: "Producto eliminado",
                        );
                        // _productosCardKey.currentState!.cargarDatos();
                        widget.onRefresh();
                      }

                      if (resultado != 1) {
                        SnackBarNotification.mostrarMensaje(
                          context,
                          mensaje: "Algo Salio mal",
                          color: Colors.red,
                        );
                      }
                    },
                    child: const Icon(Icons.delete),
                  ),

                if (widget.producto.estatus == 0)
                  ElevatedButton(
                    onPressed: () async {

                      final abrirDialogQuestion = await showDialog(
                        barrierDismissible: false,
                        context: context, 
                        builder:  (BuildContext context) => DialogQuestion(
                          titulo: "Habilitar Producto", 
                          mensaje: "¿Desea habilitar el producto ${widget.producto.nombre}?"
                        )
                      );

                      return;
                      final resultado = await habilitarProducto(
                        widget.producto.id,
                      );

                      if (resultado == 1) {
                        SnackBarNotification.mostrarMensaje(
                          context,
                          mensaje: "Producto habilitado",
                        );
                        // _productosCardKey.currentState!.initState();
                        widget.onRefresh();
                      }

                      if (resultado != 1) {
                        SnackBarNotification.mostrarMensaje(
                          context,
                          mensaje: "Algo Salio mal",
                          color: Colors.red,
                        );
                      }
                    },
                    child: const Icon(Icons.check_circle_outline_outlined),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String verificarNombre(String? nombre) {
    if (nombre == null || nombre.isEmpty) {
      return "Sin nombre";
    }

    return nombre;
  }

  String verificarExistencias(int? existencias) {
    if (existencias == null) {
      return "Sin valor";
    }

    return existencias.toString();
  }

  String verificarPrecio(double? precio) {
    if (precio == null) {
      return "Sin precio";
    }

    return precio.toString();
  }

  Future<int> deshabilitarProducto(int? id) async {
    if (id == null) {
      return 0;
    }

    return ProductoController.instance.deshabilitarProducto(id);
  }

  Future<int> habilitarProducto(int? id) async {
    if (id == null) {
      return 0;
    }

    return ProductoController.instance.habilitarProducto(id);
  }
}
