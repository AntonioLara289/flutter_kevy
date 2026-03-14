import 'package:flutter/material.dart';
import 'package:flutter_kevy_admin/screens/dialogs/dialog_agregar_inventario.dart';
import 'package:flutter_kevy_admin/screens/tabs/inventario_tab.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.warehouse_outlined), text: 'Inventario'),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Kevy Administración'),
          ),
          body: const TabBarView(
            children: [
              InventarioTab(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () { 
          //     showDialog(
          //       context: context, 
          //       builder: (BuildContext context) => const DialogAgregarInventario()
          //     );
          //     debugPrint("Presionado");
          //   },
          //   tooltip: 'Agregar Producto',
          //   child: const Icon(Icons.add),
          // ),
        ),
      ),
    );
  }
}