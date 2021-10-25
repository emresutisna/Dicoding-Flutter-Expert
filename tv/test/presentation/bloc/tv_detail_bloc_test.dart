import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  test('initial state should be empty', () {
    expect(tvDetailBloc.state, TvEmpty());
  });
  final tId = 1402;

  final tTvModel = TvDetail(
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

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(tTvModel));

      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(tId)),
    expect: () => [
      TvLoading(),
      TvHasData(tTvModel),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when get tv detail is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(tId)),
    expect: () => [
      TvLoading(),
      TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
    },
  );
}
