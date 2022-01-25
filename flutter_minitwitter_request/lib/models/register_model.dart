class RegisterResponse {
  RegisterResponse({
    required this.token,
    required this.username,
    required this.email,
    required this.role,
    required this.photoUrl,
    required this.created,
    required this.active,
  });
  late final String token;
  late final String username;
  late final String email;
  late final String role;
  late final String photoUrl;
  late final String created;
  late final bool active;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    username = json['username'];
    email = json['email'];
    role = json['role'];
    photoUrl = json['photoUrl'];
    created = json['created'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['username'] = username;
    _data['email'] = email;
    _data['role'] = role;
    _data['photoUrl'] = photoUrl;
    _data['created'] = created;
    _data['active'] = active;
    return _data;
  }
}

class RegisterDto {
  RegisterDto(
      {required this.email, required this.password, required this.username});
  late final String email;
  late final String password;
  late final String username;
  late final String code = "UDEMYANDROID";

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['username'] = username;
    _data['code'] = code;

    return _data;
  }
}
