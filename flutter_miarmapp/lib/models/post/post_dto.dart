class PostDto {
  PostDto({
    required this.titulo,
    required this.descripcion,
    required this.tipoPublicacion,
  });
  late final String titulo;
  late final String descripcion;
  late final String tipoPublicacion;

  PostDto.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    tipoPublicacion = json['tipoPublicacion'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['titulo'] = titulo;
    _data['descripcion'] = descripcion;
    _data['tipoPublicacion'] = tipoPublicacion;
    return _data;
  }
}
