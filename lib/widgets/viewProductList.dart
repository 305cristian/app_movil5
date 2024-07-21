import 'package:flutter/material.dart';
import 'package:app_movil5/models/producto.dart';
import 'package:app_movil5/services/firebase_service.dart';

class ViewProductList extends StatefulWidget {
  @override
  _ViewProductList createState() => _ViewProductList();
}

class _ViewProductList extends State<ViewProductList> {
  final FirebaseService _firebaseService = new FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Productos"),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Producto>>(
          future: _firebaseService.getProductos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay productos disponibles'));
            }

            List<Producto> productos = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: viewProductCard(productos[index]));
              },
            );
          } //
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "/add");
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget viewProductCard(Producto producto) {
    return Dismissible(
      onDismissed: (_) async {
        await _firebaseService.deleteProducto(producto.uuid);
      },
      confirmDismiss: (direction) async {
        bool result = false;
        result = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Esta seguro de eliminar el producto"),
                actions: [
                  TextButton(
                      onPressed: () {
                        return Navigator.pop(context, false);
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                      onPressed: () {
                        return Navigator.pop(context, true);
                      },
                      child: const Text("Si"))
                ],
              );
            });
        return result;
      },
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      direction: DismissDirection.endToStart,
      key: Key(producto.uuid),
      child: GestureDetector(
        onTap: (() async {
          await Navigator.pushNamed(context, "/edit", arguments: {
            "uuid": producto.uuid,
            "nombre": producto.nombre,
            "descripcion": producto.descripcion,
            "precio": producto.precio,
          });
          setState(() {});
        }),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10)),
                    child: Image.network(
                      producto.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              producto.nombre,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Text(
                              producto.descripcion,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${producto.precio.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.teal),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  print(
                                      'Agregado al carrito ${producto.nombre}');
                                },
                                icon: Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                ),
                                label: Text(""),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
