import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _FormularioStateLogin();
}

class _FormularioStateLogin extends State<Login> {
  final GlobalKey<FormState> _formulario = GlobalKey<FormState>();
  String _usuario = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.amber[100]!, Colors.blue[100]!])),
      padding: const EdgeInsets.all(20),
      child: Form(
          key: _formulario,
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        icon: const Icon(Icons.person, color: Colors.grey),
                        hintText: "Usuario o email",
                        border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre';
                      }
                      return null; // todo salio bien
                    },
                    onSaved: (value) => _usuario = value!,
                  )),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        icon: const Icon(Icons.key, color: Colors.grey),
                        hintText: "Contraseña",
                        border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa una contraseña';
                      }
                      if (value!.length < 6) {
                        return "La contraseña debe tener como mínimo 6 caracteres";
                      }
                      return null; // todo salio bien
                    },
                    onSaved: (value) => _password = value!,
                  )),
              //Expanded(child: Container()),
              const SizedBox(height: 10),
              Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formulario.currentState!.validate()) {
                        _formulario.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Procesando datos")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Ha ocurrido un error al procesar los datos")));
                      }
                    },
                    icon: Icon(Icons.login, color: Colors.white),
                    label: Text("Login", style: TextStyle(color: Colors.white )),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,

                        padding:
                            const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ))
            ],
          )),
    );
  }
}
