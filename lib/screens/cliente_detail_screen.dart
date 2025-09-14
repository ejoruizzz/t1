import 'package:flutter/material.dart';
import '../models/cliente.dart';
import 'cliente_form_screen.dart';

class ClienteDetailScreen extends StatelessWidget {
  final Cliente cliente;

  const ClienteDetailScreen({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Cliente'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClienteFormScreen(cliente: cliente),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue,
                        child: Text(
                          cliente.nombre.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Text(
                        cliente.nombreCompleto,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (cliente.edad != null)
                      Center(
                        child: Text(
                          '${cliente.edad} años',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                              icon: Icons.person,
                              label: 'Nombre',
                              value: cliente.nombre,
                            ),
                            if (cliente.apellido != null &&
                                cliente.apellido!.isNotEmpty) ...[
                              Divider(),
                              _buildDetailRow(
                                icon: Icons.person_outline,
                                label: 'Apellido',
                                value: cliente.apellido!,
                              ),
                            ],
                            Divider(),
                            _buildDetailRow(
                              icon: Icons.email,
                              label: 'Email',
                              value: cliente.email,
                            ),
                            if (cliente.telefono != null &&
                                cliente.telefono!.isNotEmpty) ...[
                              Divider(),
                              _buildDetailRow(
                                icon: Icons.phone,
                                label: 'Teléfono',
                                value: cliente.telefono!,
                              ),
                            ],
                            if (cliente.direccion != null &&
                                cliente.direccion!.isNotEmpty) ...[
                              Divider(),
                              _buildDetailRow(
                                icon: Icons.location_on,
                                label: 'Dirección',
                                value: cliente.direccion!,
                              ),
                            ],
                            if (cliente.fechanacimiento != null) ...[
                              Divider(),
                              _buildDetailRow(
                                icon: Icons.calendar_today,
                                label: 'Fecha de Nacimiento',
                                value: cliente.fechaNacimientoFormateada!,
                              ),
                            ],
                            if (cliente.edad != null) ...[
                              Divider(),
                              _buildDetailRow(
                                icon: Icons.cake,
                                label: 'Edad',
                                value: '${cliente.edad} años',
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ClienteFormScreen(cliente: cliente),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                            label: Text('Editar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Aquí podrías implementar funciones como llamar o enviar email
                              _showContactOptions(context);
                            },
                            icon: Icon(Icons.contact_phone),
                            label: Text('Contactar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
 /*
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }*/

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Contactar a ${cliente.nombre}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.email, color: Colors.blue),
                title: Text('Enviar Email'),
                subtitle: Text(cliente.email),
                onTap: () {
                  Navigator.pop(context);
                  // Implementar abrir app de email
                },
              ),
              if (cliente.telefono != null)
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.green),
                  title: Text('Llamar'),
                  subtitle: Text(cliente.telefono!),
                  onTap: () {
                    Navigator.pop(context);
                    // Implementar llamada telefónica
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
