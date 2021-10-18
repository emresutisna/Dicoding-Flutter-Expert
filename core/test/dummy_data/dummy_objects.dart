import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tv_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTv = Tv(
  backdropPath: "/wvdWb5kTQipdMDqCclC6Y3zr4j3.jpg",
  firstAirDate: "2010-10-31",
  genreIds: [10759, 18, 10765],
  id: 1402,
  name: "The Walking Dead",
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "The Walking Dead",
  overview:
      "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
  popularity: 975.892,
  posterPath: "/w21lgYIi9GeUH5dO8l3B9ARZbCB.jpg",
  voteAverage: 8.1,
  voteCount: 11802,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: "/wvdWb5kTQipdMDqCclC6Y3zr4j3.jpg",
  firstAirDate: "2010-10-31",
  genres: [
    Genre(id: 10759, name: "Action & Adventure"),
    Genre(id: 18, name: "Drama"),
    Genre(id: 10765, name: "Sci-Fi & Fantasy")
  ],
  id: 1402,
  lastAirDate: "2021-10-03",
  name: "The Walking Dead",
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "The Walking Dead",
  overview:
      "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
  popularity: 975.892,
  posterPath: "/w21lgYIi9GeUH5dO8l3B9ARZbCB.jpg",
  seasons: [
    Season(
        airDate: "2010-10-11",
        episodeCount: 53,
        id: 3646,
        name: "Specials",
        overview: "",
        posterPath: "/mjUvUEzOwnMz6fx75RHGOqwmPnM.jpg",
        seasonNumber: 0),
    Season(
        airDate: "2010-10-31",
        episodeCount: 6,
        id: 3643,
        name: "Season 1",
        overview:
            "Rick Grimes embarks on a survivalist adventure in a post-zombie apocalypse Atlanta.",
        posterPath: "/yaOB2Y8GcoXwjNQ3apq67bMbNHF.jpg",
        seasonNumber: 1),
  ],
  voteAverage: 8.1,
  voteCount: 11802,
);

final testWatchlistTv = Tv.watchlist(
  id: 1402,
  name: 'The Walking Dead',
  posterPath: '/w21lgYIi9GeUH5dO8l3B9ARZbCB.jpg',
  overview:
      "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
);

final testTvTable = TvTable(
  id: 1402,
  name: 'The Walking Dead',
  posterPath: '/w21lgYIi9GeUH5dO8l3B9ARZbCB.jpg',
  overview:
      "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
);

final testTvMap = {
  'id': 1402,
  'overview':
      "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
  'posterPath': '/w21lgYIi9GeUH5dO8l3B9ARZbCB.jpg',
  'name': 'The Walking Dead',
};
