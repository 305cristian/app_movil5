import 'package:app_movil5/services/firebase_service.dart';
import 'package:flutter/material.dart';

class EditNewPage extends StatefulWidget {
  const EditNewPage({super.key});

  @override
  State<EditNewPage> createState() => _EditNewPageState();
}

class _EditNewPageState extends State<EditNewPage> {
  final TextEditingController _nombre = TextEditingController(text: "");
  final TextEditingController _descripcion = TextEditingController(text: "");
  final TextEditingController _precio = TextEditingController(text: "");
  final FirebaseService _firebaseService = new FirebaseService();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _nombre.text = arguments["nombre"];
    _descripcion.text = arguments["descripcion"];
    _precio.text = (arguments["precio"] as double).toStringAsFixed(2);
    final _uuid = arguments["uuid"];
    return Scaffold(
      appBar: AppBar(title: const Text("Actualizar Productos")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nombre,
              decoration: const InputDecoration(hintText: "Ingrese el nombre"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descripcion,
              decoration:
                  const InputDecoration(hintText: "Ingrese una descripción"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _precio,
              decoration: const InputDecoration(hintText: "Ingrese el precio"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  double precio = double.tryParse(_precio.text) ?? 0.0;
                  await _firebaseService
                      .updateProducto(
                          _uuid, _nombre.text, _descripcion.text, precio)
                      .then((_) {
                    Navigator.pop(context);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Producto agregado con éxito')),
                  );
                },
                child: const Text("Actualizar"))
          ],
        ),
      ),
    );
  }
}
