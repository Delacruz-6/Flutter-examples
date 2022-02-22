class UserResponse {
  UserResponse({
    required this.email,
    required this.perfil,
    required this.userName,
    required this.avatar,
    required this.posts,
  });
  late final String email;
  late final String perfil;
  late final String userName;
  late final String avatar;
  late final List<Posts> posts;

  UserResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    perfil = json['perfil'];
    userName = json['userName'];
    avatar = json['avatar'];
    posts = List.from(json['posts']).map((e) => Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['perfil'] = perfil;
    _data['userName'] = userName;
    _data['avatar'] = avatar;
    _data['posts'] = posts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Posts {
  Posts({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.ficheroMob,
    required this.perfil,
  });
  late final int id;
  late final String titulo;
  late final String descripcion;
  late final String ficheroMob;
  late final String perfil;

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    ficheroMob = json['ficheroMob'];
    perfil = json['perfil'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['descripcion'] = descripcion;
    _data['ficheroMob'] = ficheroMob;
    _data['perfil'] = perfil;
    return _data;
  }
}
