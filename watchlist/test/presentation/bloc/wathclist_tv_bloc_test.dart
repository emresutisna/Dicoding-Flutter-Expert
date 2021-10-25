import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'wathclist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchlistTvs);
  });

  test('initial state should be empty', () {
    expect(watchlistTvBloc.state, WatchlistTvEmpty());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, HasData] when watchlist data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right(testTvList));

      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvs()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, Error] when get watchlist tvs is unsuccessful',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvs()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );
}
