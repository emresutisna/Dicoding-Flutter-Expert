import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.originCountry,
    required this.name,
    required this.originalLanguage,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
  });

  Tv.watchlist(
      {required this.id,
      required this.overview,
      required this.posterPath,
      required this.name});

  String? backdropPath;
  List<int>? genreIds;
  List<String>? originCountry;
  int id;
  String? originalName;
  String overview;
  double? popularity;
  String? posterPath;
  String name;
  String? originalLanguage;
  double? voteAverage;
  int? voteCount;
  String? firstAirDate;

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        originCountry,
        name,
        originalLanguage,
        voteAverage,
        voteCount,
      ];
}
