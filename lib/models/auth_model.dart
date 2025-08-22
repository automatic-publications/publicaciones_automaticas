class AuthModel {
  int? id;
  String? username;
  String? nombre;
  String? apellido;
  String? correo;
  String? celular;
  String? token;
  bool? isLogged;

  AuthModel({
    this.id,
    this.username,
    this.nombre,
    this.apellido,
    this.correo,
    this.celular,
    this.token,
    this.isLogged,
  });

  factory AuthModel.fromJson(Map<String, dynamic> jsonData) {
    return AuthModel(
      id: jsonData['id'],
      username: jsonData['username'],
      nombre: jsonData['nombre'],
      apellido: jsonData['apellido'],
      correo: jsonData['correo'],
      celular: jsonData['celular'],
      token: jsonData['access_token'] ?? '', 
      isLogged: true,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'nombre': nombre,
    'apellido': apellido,
    'correo': correo,
    'celular': celular,
    'access_token': token,
    'isLogged': isLogged,
  };
}
