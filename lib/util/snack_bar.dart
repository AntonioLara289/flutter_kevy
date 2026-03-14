import 'package:flutter/material.dart';

class SnackBarNotification {
  // Método estático: se puede llamar sin instanciar la clase
  static void mostrarMensaje(BuildContext context, {
    required String mensaje, 
    Color color = Colors.blue,
    //milisegundos
    int duration = 3000
  }) {
    // 1. Limpiamos cualquier snack previo
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // 2. Mostramos el nuevo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: Duration(milliseconds: duration),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}