class TeamsResponse {
  TeamsResponse({
    required this.data,
    required this.meta,
  });
  late final List<Teams> data;
  late final Meta meta;

  TeamsResponse.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Teams.fromJson(e)).toList();
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Teams {
  Teams({
    required this.id,
    required this.abbreviation,
    required this.city,
    required this.conference,
    required this.division,
    required this.fullName,
    required this.name,
  });
  late final int id;
  late final String abbreviation;
  late final String city;
  late final String conference;
  late final String division;
  late final String fullName;
  late final String name;

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abbreviation = json['abbreviation'];
    city = json['city'];
    conference = json['conference'];
    division = json['division'];
    fullName = json['full_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['abbreviation'] = abbreviation;
    _data['city'] = city;
    _data['conference'] = conference;
    _data['division'] = division;
    _data['full_name'] = fullName;
    _data['name'] = name;
    return _data;
  }
}

class Meta {
  Meta({
    required this.totalPages,
    required this.currentPage,
    required this.nextPage,
    required this.perPage,
    required this.totalCount,
  });
  late final int totalPages;
  late final int currentPage;
  late final int nextPage;
  late final int perPage;
  late final int totalCount;

  Meta.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    nextPage = json['next_page'];
    perPage = json['per_page'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_pages'] = totalPages;
    _data['current_page'] = currentPage;
    _data['next_page'] = nextPage;
    _data['per_page'] = perPage;
    _data['total_count'] = totalCount;
    return _data;
  }
}
