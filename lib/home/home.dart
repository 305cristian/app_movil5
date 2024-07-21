import 'package:flutter/material.dart';
import 'package:app_movil5/widgets/login.dart';
import 'package:app_movil5/widgets/viewProductList.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('APPS'),
        ),
        body: ViewProductList());
  }
}
