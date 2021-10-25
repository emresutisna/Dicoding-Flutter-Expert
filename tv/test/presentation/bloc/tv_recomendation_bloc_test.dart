import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv/presentation/bloc/tv_recomendation_bloc.dart';

import 'tv_recomendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecomendationBloc tvRecomendationBloc;
  late MockGetTvRecommendations mockGetTvRecomendations;

  setUp(() {
    mockGetTvRecomendations = MockGetTvRecommendations();
    tvRecomendationBloc = TvRecomendationBloc(mockGetTvRecomendations);
  });

  test('initial state should be empty', () {
    expect(tvRecomendationBloc.state, TvRecomendationInitial());
  });

  final tId = 1402;

  final tTv = Tv(
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
  final tTvs = <Tv>[tTv];

  blocTest<TvRecomendationBloc, TvRecomendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvRecomendations.execute(tId))
          .thenAnswer((_) async => Right(tTvs));

      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecomendation(tId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecomendationsHasData(tTvs),
    ],
    verify: (bloc) {
      verify(mockGetTvRecomendations.execute(tId));
    },
  );

  blocTest<TvRecomendationBloc, TvRecomendationState>(
    'Should emit [Loading, Error] when get tv recomendation is unsuccessful',
    build: () {
      when(mockGetTvRecomendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecomendationBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecomendation(tId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvRecomendations.execute(tId));
    },
  );
}
