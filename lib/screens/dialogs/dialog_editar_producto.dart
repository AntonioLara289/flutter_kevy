
import 'package:flutter/material.dart';
import 'package:flutter_kevy_admin/models/producto.dart';

class DialogEditarProducto extends StatefulWidget{

  final Producto producto;

  const DialogEditarProducto({super.key, required this.producto});

  @override
  State<StatefulWidget> createState() => _DialogEditarProducto();
}

class _DialogEditarProducto extends State<DialogEditarProducto>{

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nombreProducto = TextEditingController();
  final TextEditingController cantidadProducto = TextEditingController();
  final TextEditingController precioProducto = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombreProducto.text = widget.producto.nombre;
    cantidadProducto.text = widget.producto.existencias.toString();
    precioProducto.text = widget.producto.precio.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Padding(
        padding: EdgeInsetsGeometry.all(15.00),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Agregar productos', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 96, 114, 129)),textAlign: .center),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
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
    Expanded( // El botón de cancelar ahora es flexible
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context, false),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
        child: const Text("Cancelar"),
      ),
    ),
    const SizedBox(width: 15), // Un respiro entre los botones
    Expanded( // El botón de actualizar también
      child: ElevatedButton(
        onPressed: () { /* Tu lógica de update */ },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
        child: const Text("Actualizar"),
      ),
    ),
  ],
                // ElevatedButton(
                //     onPressed: () async {

                //      if (_formKey.currentState!.validate()) {
                //         // 1. Ejecutamos el guardado
                //         bool exito = await guardarProducto();
                        
                //         if (exito) {
                //           // 2. Creamos el objeto para devolverlo (opcional)
                //           // Producto productoCreado = Producto(
                //           //   nombre: nombreProducto.text,
                //           //   existencias: int.parse(cantidadProducto.text),
                //           //   precio: double.parse(precioProducto.text),
                //           // );

                //           // 3. Cerramos regresando el objeto (o simplemente true)
                //           Navigator.pop(context, true); 
                //         }
                //       }

                //       // if (_formKey.currentState!.validate()) {
                //       //   guardarProducto();
                //       //   _formKey.currentState!.reset();
                //       //   Navigator.pop(context);
                //       // }
                //     },
                //     style: TextButton.styleFrom(
                //       backgroundColor: Colors.green,
                //       foregroundColor: Colors.white,
                //         // disabledForegroundColor: Colors.red,
                //     ),
                //     child: Text("Guardar Producto"),
                //   ),
            ),
        ],
      ),),
    );
  }

  void printProducto(){
    print("Producto: ${widget.producto}");
  }
}