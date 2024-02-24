class ScoreUpdate {
  Batsman batsman;
  Batsman2 batsman2;
  Bowler bowler;
  Striker striker;
  Scores scores;

  ScoreUpdate({required this.batsman,required this.batsman2, required this.bowler, required this.striker, required this.scores});

  factory ScoreUpdate.fromJson(Map<String, dynamic> json) {
    return ScoreUpdate(
      batsman: Batsman.fromJson(json['batsman']),
      batsman2: Batsman2.fromJson(json['batsman_2']),
      bowler: Bowler.fromJson(json['bowler']),
      striker: Striker.fromJson(json['striker']),
      scores: Scores.fromJson(json['scores']),
    );
  }
}

class Batsman {
  int id;
  int run;
  dynamic balls;

  Batsman({required this.id, required this.run, required this.balls});

  factory Batsman.fromJson(Map<String, dynamic> json) {
    return Batsman(
      id: json['id'],
      run: json['run'],
      balls: json['balls'],
    );
  }
}
class Batsman2 {
  int id;
  int run;
  dynamic balls;

  Batsman2({required this.id, required this.run, required this.balls});

  factory Batsman2.fromJson(Map<String, dynamic> json) {
    return Batsman2(
      id: json['id'],
      run: json['run'],
      balls: json['balls'],
    );
  }
}

class Bowler {
  int id;
  dynamic balls;
  int runs;
  int wicket;
  int maidensOver;

  Bowler({required this.id, required this.balls, required this.runs, required this.wicket, required this.maidensOver});

  factory Bowler.fromJson(Map<String, dynamic> json) {
    return Bowler(
      id: json['id'],
      balls: json['balls'],
      runs: json['runs'],
      wicket: json['wicket'],
      maidensOver: json['mainders_over'],
    );
  }
}

class Striker {
  int isStriker;

  Striker({required this.isStriker});

  factory Striker.fromJson(Map<String, dynamic> json) {
    return Striker(
      isStriker: json['is_striker'],
    );
  }
}

class Scores {
  int totalRun;
  dynamic totalOver;
  dynamic matchTotalOvers;

  Scores({required this.totalRun, required this.totalOver, required this.matchTotalOvers});

  factory Scores.fromJson(Map<String, dynamic> json) {
    return Scores(
      totalRun: json['total_run'],
      totalOver: json['total_over'],
      matchTotalOvers: json['match_total_overs'],
    );
  }
}
