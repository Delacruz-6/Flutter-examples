class StatsResponse {
  StatsResponse({
    required this.data,
    required this.meta,
  });
  late final List<Stats> data;
  late final Meta meta;

  StatsResponse.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Stats.fromJson(e)).toList();
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Stats {
  Stats({
    required this.id,
    required this.ast,
    required this.blk,
    required this.dreb,
    required this.fg3Pct,
    required this.fg3a,
    required this.fg3m,
    required this.fgPct,
    required this.fga,
    required this.fgm,
    required this.ftPct,
    required this.fta,
    required this.ftm,
    required this.game,
    required this.min,
    required this.oreb,
    required this.pf,
    required this.player,
    required this.pts,
    required this.reb,
    required this.stl,
    required this.team,
    required this.turnover,
  });
  late final int id;
  late final int ast;
  late final int blk;
  late final int dreb;
  late final double fg3Pct;
  late final int fg3a;
  late final int fg3m;
  late final double fgPct;
  late final int fga;
  late final int fgm;
  late final double ftPct;
  late final int fta;
  late final int ftm;
  late final Game game;
  late final String min;
  late final int oreb;
  late final int pf;
  late final Player player;
  late final int pts;
  late final int reb;
  late final int stl;
  late final Team team;
  late final int turnover;

  Stats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ast = json['ast'];
    blk = json['blk'];
    dreb = json['dreb'];
    fg3Pct = json['fg3_pct'];
    fg3a = json['fg3a'];
    fg3m = json['fg3m'];
    fgPct = json['fg_pct'];
    fga = json['fga'];
    fgm = json['fgm'];
    ftPct = json['ft_pct'];
    fta = json['fta'];
    ftm = json['ftm'];
    game = Game.fromJson(json['game']);
    min = json['min'];
    oreb = json['oreb'];
    pf = json['pf'];
    player = Player.fromJson(json['player']);
    pts = json['pts'];
    reb = json['reb'];
    stl = json['stl'];
    team = Team.fromJson(json['team']);
    turnover = json['turnover'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['ast'] = ast;
    _data['blk'] = blk;
    _data['dreb'] = dreb;
    _data['fg3_pct'] = fg3Pct;
    _data['fg3a'] = fg3a;
    _data['fg3m'] = fg3m;
    _data['fg_pct'] = fgPct;
    _data['fga'] = fga;
    _data['fgm'] = fgm;
    _data['ft_pct'] = ftPct;
    _data['fta'] = fta;
    _data['ftm'] = ftm;
    _data['game'] = game.toJson();
    _data['min'] = min;
    _data['oreb'] = oreb;
    _data['pf'] = pf;
    _data['player'] = player.toJson();
    _data['pts'] = pts;
    _data['reb'] = reb;
    _data['stl'] = stl;
    _data['team'] = team.toJson();
    _data['turnover'] = turnover;
    return _data;
  }
}

class Game {
  Game({
    required this.id,
    required this.date,
    required this.homeTeamId,
    required this.homeTeamScore,
    required this.season,
    required this.visitorTeamId,
    required this.visitorTeamScore,
  });
  late final int id;
  late final String date;
  late final int homeTeamId;
  late final int homeTeamScore;
  late final int season;
  late final int visitorTeamId;
  late final int visitorTeamScore;

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    homeTeamId = json['home_team_id'];
    homeTeamScore = json['home_team_score'];
    season = json['season'];
    visitorTeamId = json['visitor_team_id'];
    visitorTeamScore = json['visitor_team_score'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date;
    _data['home_team_id'] = homeTeamId;
    _data['home_team_score'] = homeTeamScore;
    _data['season'] = season;
    _data['visitor_team_id'] = visitorTeamId;
    _data['visitor_team_score'] = visitorTeamScore;
    return _data;
  }
}

class Player {
  Player({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.teamId,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String position;
  late final int teamId;

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    position = json['position'];
    teamId = json['team_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['position'] = position;
    _data['team_id'] = teamId;
    return _data;
  }
}

class Team {
  Team({
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

  Team.fromJson(Map<String, dynamic> json) {
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
