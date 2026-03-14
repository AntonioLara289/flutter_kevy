import 'package:flutter/material.dart';
import 'package:flutter_kevy_admin/models/producto.dart';
import 'package:flutter_kevy_admin/screens/dialogs/dialog_agregar_inventario.dart';
import 'package:flutter_kevy_admin/storage/db_init.dart';
import 'package:flutter_kevy_admin/storage/producto_controller.dart';
import 'package:flutter_kevy_admin/util/productos_card.dart';
import 'package:flutter_kevy_admin/util/button_snack_bar.dart';
import 'package:flutter_kevy_admin/util/snack_bar.dart';

class InventarioTab extends StatefulWidget {
  const InventarioTab({super.key});

  @override
  State<InventarioTab> createState() => _InventarioTabState();
}

class _InventarioTabState extends State<InventarioTab> {
  // 2. Ahora apunta al State público
  final GlobalKey<ProductosCardState> _productosKey =
      GlobalKey<ProductosCardState>();

  final List<Map<String, dynamic>> options = [
    {
      'label': 'Habilitados',
      'mostrar_habilitados': true,
      'mostrar_deshabilitados': false,
    },
    {
      'label': 'Deshabilitados',
      'mostrar_habilitados': false,
      'mostrar_deshabilitados': true,
    },
    {
      'label': 'Todos',
      'mostrar_habilitados': true,
      'mostrar_deshabilitados': true,
    },
  ];

  Map<String, dynamic>? estatusSelected; // The currently selected value
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    estatusSelected = options[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      body: Center(
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .center,
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Buscar producto',
                      // icon: Icon(Icons.inventory_2),
                    ),
                    // validator: (String? value) {
                    //   if (value == null || value.isEmpty) {
                    //     return "Este campo es obligatorio";
                    //   }

                    //   if (value.length < 3) {
                    //     return "El minimo de letras son 3";
                    //   }

                    //   return null;
                    // },
                  ),
                ),
                const SizedBox(width: 25),
                DropdownButton<Map<String, dynamic>>(
                  value: estatusSelected,
                  hint: const Text(
                    'Filtrar Productos',
                  ), // Text to display when nothing is selected
                  items: options.map((Map<String, dynamic> option) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: option,
                      child: Text(option['label']),
                    );
                  }).toList(),
                  onChanged: (Map<String, dynamic>? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      estatusSelected = value;
                      // print('value: ${value}');

                      // _productosKey.currentState!.cargarDatos();
                    });
                  },
                ),
              ],
            ),

            Expanded(
              flex: 5,
              child: ProductosCard(
                key: _productosKey,
                mostrar_habilitados: estatusSelected!['mostrar_habilitados'],
                mostrar_deshabilitados:
                    estatusSelected!['mostrar_deshabilitados'],
              ), // Agregamos la llave aquí
            ),
            // const Spacer(),
            // Row(
            //   // mainAxisSize: .max,
            //   mainAxisAlignment: .end,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(5.0),
            //       child: FloatingActionButton(
            //         onPressed: () async {
            //           // final resultado = await showDialog(
            //           //   barrierDismissible: false,
            //           //   context: context,
            //           //   builder: (BuildContext context) =>
            //           //       DialogAgregarInventario(),
            //           // );

            //           final resultado = true;
            //           // print("Resultado: ${resultado}");

            //           if (resultado) {
            //             _productosKey.currentState!.cargarDatos();

            //             SnackBarNotification.mostrarMensaje(
            //               context,
            //               mensaje: "Producto Agregado",
            //               color: Colors.teal,
            //               duration: 5000,
            //             );
            //           }

            //           // debugPrint("Presionado");
            //         },
            //         tooltip: 'Agregar Producto',
            //         child: const Icon(Icons.add),
            //       ),
            //     ),
            //   ],
            // ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final resultado = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => DialogAgregarInventario(),
          );
          // print("Resultado: ${resultado}");

          if (resultado) {
            _productosKey.currentState!.cargarDatos();

            SnackBarNotification.mostrarMensaje(
              context,
              mensaje: "Producto Agregado",
              color: Colors.teal,
              duration: 5000,
            );
          }

          // debugPrint("Presionado");
        },
        tooltip: 'Agregar Producto',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Producto>> getProductos() async {
    final productos = await ProductoController.instance.getProductos();

    return productos;
  }

  void mostrarSnack() {
    SnackBarNotification.mostrarMensaje(
      context,
      mensaje: "¡Producto actualizado correctamente!",
      color: Colors.green,
    );
  }
}


            // Card(
            //   clipBehavior: Clip.hardEdge,
            //   child: InkWell(
            //     splashColor: Colors.blueAccent.withAlpha(50),
            //     onTap: (){
            //       debugPrint("Texto");
            //     },
            //     child: const SizedBox(
            //       width: 300,
            //       height: 200,
            //       child: Text("Aqui se mostrarán los productos"),
            //     ),
            //   ),
            // )