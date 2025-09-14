import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_form_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product producto;
  const ProductDetailScreen({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductFormScreen(producto: producto),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(producto.nombre, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Descripción: ${producto.descripcion}'),
                SizedBox(height: 8),
                Text('Precio: \$${producto.precio.toStringAsFixed(2)}'),
                SizedBox(height: 8),
                Text('Stock: ${producto.stock}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

