class Cliente {
  final int? id;
  final String nombre;
  final String? apellido;
  final DateTime? fechanacimiento;
  final String email;
  final String? telefono;
  final String? direccion;

  Cliente({
    this.id,
    required this.nombre,
    this.apellido,
    this.fechanacimiento,
    required this.email,
    this.telefono,
    this.direccion
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      fechanacimiento: json['fechanacimiento'] != null 
          ? DateTime.parse(json['fechanacimiento']) 
          : null,
      email: json['email'],
      telefono: json['telefono'],
      direccion: json['direccion']
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'fechanacimiento': fechanacimiento?.toIso8601String(),
      'email': email,
      'telefono': telefono,
      'direccion': direccion,
    };
  }

  Cliente copyWith({
    int? id,
    String? nombre,
    String? apellido,
    DateTime? fechanacimiento,
    String? email,
    String? telefono,
    String? direccion,
  }) {
    return Cliente(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      fechanacimiento: fechanacimiento ?? this.fechanacimiento,
      email: email ?? this.email,
      telefono: telefono ?? this.telefono,
      direccion: direccion ?? this.direccion,
    );
  }

  // Getter para obtener el nombre completo
  String get nombreCompleto {
    if (apellido != null && apellido!.isNotEmpty) {
      return '$nombre $apellido';
    }
    return nombre;
  }
  
  // Getter para obtener la edad (solo si tiene fecha de nacimiento)
  int? get edad {
    if (fechanacimiento == null) return null;
    
    final now = DateTime.now();
    int age = now.year - fechanacimiento!.year;
    if (now.month < fechanacimiento!.month || 
        (now.month == fechanacimiento!.month && now.day < fechanacimiento!.day)) {
      age--;
    }
    return age;
  }

  // Formatter para fecha de nacimiento
  String? get fechaNacimientoFormateada {
    if (fechanacimiento == null) return null;
    return '${fechanacimiento!.day}/${fechanacimiento!.month}/${fechanacimiento!.year}';
  }

  // Información adicional para mostrar
  String get infoAdicional {
    List<String> info = [];
    
    if (edad != null) {
      info.add('${edad} años');
    }
    
    if (fechaNacimientoFormateada != null) {
      info.add(fechaNacimientoFormateada!);
    }
    
    if (telefono != null && telefono!.isNotEmpty) {
      info.add(telefono!);
    }
    
    return info.join(' • ');
  }
}