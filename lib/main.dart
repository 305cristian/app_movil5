import 'package:app_movil5/firebase_options.dart';
import 'package:app_movil5/home/home.dart';
import 'package:app_movil5/widgets/viewEditProduct.dart';
import 'package:app_movil5/widgets/viewNewProduct.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'App Ventas 1', initialRoute: '/', routes: {
      '/': (context) => const Home(),
      '/add': (context) => const AddNewPage(),
      '/edit': (context) => const EditNewPage(),
    });
  }
}
