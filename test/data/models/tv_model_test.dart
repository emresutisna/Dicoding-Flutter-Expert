import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
      backdropPath: '/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg',
      genreIds: [10759, 9648, 18],
      id: 93405,
      originalName: "오징어 게임",
      overview:
          "Hundreds of cash-strapped players accept a strange invitation to compete in children's games—with high stakes. But, a tempting prize awaits the victor.",
      popularity: 10219.887,
      posterPath: "/dDlEmu3EZ0Pgg93K2SVNLCjCSvE.jpg",
      originCountry: ["KR"],
      name: "Squid Game",
      originalLanguage: "ko",
      voteAverage: 7.9,
      voteCount: 6652,
      firstAirDate: "2021-09-17");

  final tTv = Tv(
      backdropPath: '/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg',
      genreIds: [10759, 9648, 18],
      id: 93405,
      originalName: "오징어 게임",
      overview:
          "Hundreds of cash-strapped players accept a strange invitation to compete in children's games—with high stakes. But, a tempting prize awaits the victor.",
      popularity: 10219.887,
      posterPath: "/dDlEmu3EZ0Pgg93K2SVNLCjCSvE.jpg",
      originCountry: ["KR"],
      name: "Squid Game",
      originalLanguage: "ko",
      voteAverage: 7.9,
      voteCount: 6652,
      firstAirDate: "2021-09-17");

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
