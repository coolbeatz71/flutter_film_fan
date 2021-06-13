import 'dart:convert';

Similar similarFromJson(String str) => Similar.fromJson(json.decode(str));

String similarToJson(Similar data) => json.encode(data.toJson());

class Similar {
  Similar({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory Similar.fromJson(Map<String, dynamic> json) => Similar(
        page: json["page"],
        results: List<Result>.from(
          json["results"].map(
            (x) => Result.fromJson(x),
          ),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(
          results.map(
            (x) => x.toJson(),
          ),
        ),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  Result({
    this.video,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.title,
    this.adult,
    this.backdropPath,
    this.id,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.voteCount,
    this.popularity,
  });

  bool video;
  double voteAverage;
  String overview;
  DateTime releaseDate;
  String title;
  bool adult;
  String backdropPath;
  int id;
  List<int> genreIds;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  int voteCount;
  double popularity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        genreIds: List<int>.from(
          json["genre_ids"].map((x) => x),
        ),
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        voteCount: json["vote_count"],
        popularity: json["popularity"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "video": video,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "genre_ids": List<dynamic>.from(
          genreIds.map((x) => x),
        ),
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "poster_path": posterPath,
        "vote_count": voteCount,
        "popularity": popularity,
      };
}
