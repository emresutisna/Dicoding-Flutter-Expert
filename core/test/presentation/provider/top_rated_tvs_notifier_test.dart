import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_top_rated_tvs.dart';
import 'package:core/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvs_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late TopRatedTvsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    notifier = TopRatedTvsNotifier(getTopRatedTvs: mockGetTopRatedTvs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

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
    voteCount: 11794,
  );

  final tTvList = <Tv>[tTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTvs.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchTopRatedTvs();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTvs.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchTopRatedTvs();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
