import 'package:app_movil5/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AddNewPage extends StatefulWidget {
  const AddNewPage({super.key});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  final TextEditingController _nombre = TextEditingController(text: "");
  final TextEditingController _descripcion = TextEditingController(text: "");
  final TextEditingController _precio = TextEditingController(text: "");
  final FirebaseService _firebaseService = new FirebaseService();
  final GlobalKey<FormState> _formulario = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear Productos")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _formulario,
            child: Column(
              children: [
                TextFormField(
                  controller: _nombre,
                  decoration:
                      const InputDecoration(hintText: "Ingrese el nombre"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descripcion,
                  decoration: const InputDecoration(
                      hintText: "Ingrese una descripción"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una descripción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                    controller: _precio,
                    decoration:
                        const InputDecoration(hintText: "Ingrese el precio"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un precio';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () async {
                      double precio = double.tryParse(_precio.text) ?? 0.0;
                      await _firebaseService
                          .saveProducto(_nombre.text, _descripcion.text, precio)
                          .then((_) {
                        Navigator.pop(context);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Producto agregado con éxito')),
                      );
                    },
                    child: const Text("Guardar"))
              ],
            )),
      ),
    );
  }
}
