import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/product_service.dart';
import '../models/product.dart';
import 'product_form_screen.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductService>(context, listen: false).getAllProductos();
    });
  }

  void _showDeleteDialog(Product producto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar producto'),
        content: Text('¿Eliminar ${producto.nombre}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final service = Provider.of<ProductService>(context, listen: false);
              final success = await service.deleteProducto(producto.id!);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Producto eliminado')),
                );
              }
            },
            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ProductService>(
        builder: (context, service, child) {
          if (service.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (service.error != null) {
            return Center(child: Text('Error al cargar productos'));
          }
          if (service.productos.isEmpty) {
            return Center(child: Text('No hay productos'));
          }
          return RefreshIndicator(
            onRefresh: () => service.getAllProductos(),
            child: ListView.builder(
              itemCount: service.productos.length,
              itemBuilder: (context, index) {
                final producto = service.productos[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(producto.nombre.substring(0, 1).toUpperCase()),
                    ),
                    title: Text(producto.nombre),
                    subtitle: Text('Precio: \$${producto.precio.toStringAsFixed(2)} - Stock: ${producto.stock}'),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductFormScreen(producto: producto),
                            ),
                          );
                        } else if (value == 'delete') {
                          _showDeleteDialog(producto);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [Icon(Icons.edit), SizedBox(width: 8), Text('Editar')],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Eliminar', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(producto: producto),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductFormScreen(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
