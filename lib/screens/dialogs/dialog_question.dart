import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogQuestion extends StatelessWidget {
  final String titulo;
  final String mensaje;
  const DialogQuestion({
    super.key,
    required this.titulo,
    required this.mensaje,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo, textAlign: .center, style: TextStyle(fontSize: 29)),
      content: SingleChildScrollView(
        // won't be scrollable
        child: Text(
          mensaje,
          textAlign: .center,
          style: TextStyle(fontSize: 22),
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text("No"),
              ),
            ),
          const SizedBox(width: 15), // Un respiro entre los botones
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text("Si"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
