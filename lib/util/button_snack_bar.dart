import 'package:flutter/material.dart';

class SnackBarExample extends StatelessWidget {
  final String textoBoton;
  final String mensaje;

  const SnackBarExample({super.key, required this.textoBoton, required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(textoBoton),
      onPressed: () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensaje),
            // action: SnackBarAction(
            //   label: '!NICE!',
            //   onPressed: () {
            //     // Code to execute.
            //   },
            // ),
            duration: Duration(milliseconds: 3000),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.blue
          ),
        );
      },
    );
  }
}