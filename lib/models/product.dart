class Product {
  final int? id;
  final String nombre;
  final String descripcion;
  final double precio;
  final int stock;

  Product({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      precio: (json['precio'] as num).toDouble(),
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'stock': stock,
    };
  }

  Product copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    double? precio,
    int? stock,
  }) {
    return Product(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
      stock: stock ?? this.stock,
    );
  }
}
