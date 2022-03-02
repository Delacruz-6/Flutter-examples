class RegisterDto {
  RegisterDto({
    required this.username,
    required this.tipo,
    required this.email,
    required this.password,
    required this.password2,
    required this.telefono,
    required this.fechaNacimiento,
  });
  late final String username;
  late final String tipo;
  late final String email;
  late final String password;
  late final String password2;
  late final int telefono;
  late final String fechaNacimiento;

  RegisterDto.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    tipo = json['tipo'];
    email = json['email'];
    password = json['password'];
    password2 = json['password2'];
    telefono = json['telefono'];
    fechaNacimiento = json['fechaNacimiento'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['tipo'] = tipo;
    _data['email'] = email;
    _data['password'] = password;
    _data['password2'] = password2;
    _data['telefono'] = telefono;
    _data['fechaNacimiento'] = fechaNacimiento;
    return _data;
  }
}
