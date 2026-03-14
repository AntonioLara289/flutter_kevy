import 'package:flutter/material.dart';
import 'package:flutter_kevy_admin/main.dart';
import 'package:flutter_kevy_admin/models/producto.dart';
import 'package:flutter_kevy_admin/storage/db_init.dart';
import 'package:flutter_kevy_admin/storage/producto_controller.dart';

class DialogAgregarInventario extends StatefulWidget {
  const DialogAgregarInventario({super.key});

  @override
  State<DialogAgregarInventario> createState() => _DialogAgregarInventario();
}

// Cambiamos el nombre para que sea claro que es el CONTENIDO del diálogo
class _DialogAgregarInventario extends State<DialogAgregarInventario> {
  Producto producto = Producto(nombre: "Prueba", existencias: 5, precio: 25.0);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nombreProducto = TextEditingController();
  final TextEditingController cantidadProducto = TextEditingController();
  final TextEditingController precioProducto = TextEditingController();

  @override
  void dispose() {
    nombreProducto.dispose();
    cantidadProducto.dispose();
    precioProducto.dispose();
  }

  @override
  void initState() {
    super.initState();
    // AQUÍ es donde mandas a llamar la carga inicial
    getProductos();
  }

  @override
  Widget build(BuildContext context) {
    // Solo devolvemos el Dialog, sin MaterialApp ni Scaffold
    return Dialog.fullscreen(
      child: Padding(
        padding: EdgeInsetsGeometry.all(15.00),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Agregar productos',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 96, 114, 129),
              ),
              textAlign: .center,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: nombreProducto,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Producto',
                      icon: Icon(Icons.inventory_2),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Este campo es obligatorio";
                      }

                      if (value.length < 3) {
                        return "El minimo de letras son 3";
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cantidadProducto,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Stock (cantidad)',
                      icon: Icon(Icons.inventory_2),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingrese una cantidad";
                      }

                      final valor = int.tryParse(value) ?? 0;

                      if (valor < 0) {
                        return "La cantidad no puede ser negativa";
                      }

                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: precioProducto,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Precio del producto',
                      icon: Icon(Icons.inventory_2),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Este campo es obligatorio";
                      }

                      double valor = double.tryParse(value) ?? 0.0;

                      if (valor < 0) {
                        return "Las existencias no pueden ser menor a 0";
                      }

                      return null;
                    },
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       guardarProducto();
                  //     }
                  //   },
                  //   child: Text("Guardar Producto"),
                  // ),
                ],
              ),
            ),
            //Esto hace que se mande hasta abajo todo
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                      // dispose();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      // disabledForegroundColor: Colors.red,
                    ),
                    child: Text("Cancelar"),
                  ),
                ),
                const SizedBox(width: 15), // Un respiro entre los botones
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // 1. Ejecutamos el guardado
                        bool exito = await guardarProducto();

                        if (exito) {
                          // 2. Creamos el objeto para devolverlo (opcional)
                          // Producto productoCreado = Producto(
                          //   nombre: nombreProducto.text,
                          //   existencias: int.parse(cantidadProducto.text),
                          //   precio: double.parse(precioProducto.text),
                          // );

                          // 3. Cerramos regresando el objeto (o simplemente true)
                          Navigator.pop(context, true);
                        }
                      }

                      // if (_formKey.currentState!.validate()) {
                      //   guardarProducto();
                      //   _formKey.currentState!.reset();
                      //   Navigator.pop(context);
                      // }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      // disabledForegroundColor: Colors.red,
                    ),
                    child: Text("Guardar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> probarGuardado() async {
    // Creamos el objeto con los datos de los controladores
    Producto nuevoProducto = Producto(
      nombre: "nombre",
      existencias: 6,
      precio: 25.00,
    );

    await ProductoController.instance.insertProducto(nuevoProducto);

    debugPrint("Guardado viejillo");
  }

  Future<bool> guardarProducto() async {
    int existencias = int.tryParse(cantidadProducto.text) ?? 0;
    double precio = double.tryParse(precioProducto.text) ?? 00;

    Producto nuevoProducto = Producto(
      nombre: nombreProducto.text,
      existencias: existencias,
      precio: precio,
      estatus: 1
    );

    try {
      // Intentamos la operación asíncrona
      await ProductoController.instance.insertProducto(nuevoProducto);

      debugPrint("¡Producto guardado exitosamente!");
      return true; // Devolvemos verdadero si funcionó
    } catch (e) {
      // Si algo falla (ej. error de SQL, NDK, o archivo ocupado)
      debugPrint("Error al insertar en la DB: $e");

      // Aquí podrías lanzar un SnackBar de error usando tu GlobalKey
      snackbarKey.currentState?.showSnackBar(
        SnackBar(content: Text("Error: No se pudo guardar el producto")),
      );

      return false; // Devolvemos falso porque hubo un fallo
    } finally {
      // Este bloque opcional se ejecuta SIEMPRE, haya error o no
      debugPrint("Proceso de guardado finalizado.");
    }
  }

  Future<bool> validarFormulario() async {
    if (_formKey.currentState!.validate()) {
      return true;
    }

    return false;
  }

  Future<void> getProductos() async {
    final productoGuardados = await ProductoController.instance.getProductos();
    debugPrint("Productos guardados: $productoGuardados");
  }
}
