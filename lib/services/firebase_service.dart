import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/producto.dart';

FirebaseFirestore _dbf = FirebaseFirestore.instance;

class FirebaseService {
  final FirebaseFirestore _dbf = FirebaseFirestore.instance;

  Future<List<Producto>> getProductos() async {
    CollectionReference collectionReferenceProductos =
        _dbf.collection('productos');
    QuerySnapshot queryProductos = await collectionReferenceProductos.get();

    return queryProductos.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return Producto(
          doc.id ?? '',
          data['nombre'] ?? '',
          data['descripcion'] ?? '',
          (data['precio'] ?? 0.0).toDouble(),
          data['imageUrl'] ?? '');
    }).toList();
  }

  Future<void> saveProducto(
      String nombre, String descripcion, double precio) async {
    await _dbf
        .collection("productos")
        .add({'nombre': nombre, "descripcion": descripcion, "precio": precio});
  }

  Future<void> updateProducto(
      String uuid, String nombre, String descripcion, double precio) async {
    final datos = {
      "nombre": nombre,
      "descripcion": descripcion,
      "precio": precio
    };
    await _dbf.collection("productos").doc(uuid).set(datos);
  }

  Future<void> deleteProducto(String uuid) async {
    await _dbf.collection("productos").doc(uuid).delete();
  }
}
