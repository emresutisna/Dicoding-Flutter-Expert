import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTvBloc nowPlayingTvBloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    nowPlayingTvBloc = PopularTvBloc(mockGetPopularTvs);
  });

  test('initial state should be empty', () {
    expect(nowPlayingTvBloc.state, PopularTvEmpty());
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

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvs));

      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    expect: () => [
      PopularTvLoading(),
      PopularTvHasData(tTvs),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Error] when get popular tvs is unsuccessful',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvs()),
    expect: () => [
      PopularTvLoading(),
      PopularTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );
}
