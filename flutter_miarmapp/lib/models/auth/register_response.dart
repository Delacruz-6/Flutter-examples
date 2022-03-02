class RegisterResponse {
  RegisterResponse({
    required this.email,
    required this.perfil,
    required this.userName,
    required this.avatar,
  });
  late final String email;
  late final String perfil;
  late final String userName;
  late final String avatar;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    perfil = json['perfil'];
    userName = json['userName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['perfil'] = perfil;
    _data['userName'] = userName;
    _data['avatar'] = avatar;
    return _data;
  }
}
