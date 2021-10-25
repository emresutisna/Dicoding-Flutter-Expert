import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTvs);
  });

  test('initial state should be empty', () {
    expect(topRatedTvBloc.state, TopRatedTvEmpty());
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

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvs.execute()).thenAnswer((_) async => Right(tTvs));

      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvHasData(tTvs),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Error] when get top rated tvs is unsuccessful',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvs()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );
}
