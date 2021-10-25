import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:watchlist/watchlist.dart';
import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListTvStatus, SaveTvWatchlist, RemoveTvWatchlist])
void main() {
  late TvWatchlistBloc watchlistBloc;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;

  setUp(() {
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    watchlistBloc = TvWatchlistBloc(
        mockGetWatchListTvStatus, mockSaveTvWatchlist, mockRemoveTvWatchlist);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, WatchlistInitial());
  });

  const tId = 1402;

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit WatchlistStatusChanged when event LoadWatchListStatus successfully',
    build: () {
      when(mockGetWatchListTvStatus.execute(tId)).thenAnswer((_) async => true);

      return watchlistBloc;
    },
    act: (bloc) => bloc.add(LoadWatchListStatus(tId)),
    expect: () => [
      WatchlistStatusChanged(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListTvStatus.execute(tId));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit WatchlistStatusChanged when event AddToWatchList successfully',
    build: () {
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(AddToWatchList(testTvDetail)),
    expect: () => [
      WatchlistStatusChanged(true),
    ],
    verify: (bloc) {
      verify(mockSaveTvWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit WatchlistError when event AddToWatchList unsuccessfull',
    build: () {
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(AddToWatchList(testTvDetail)),
    expect: () => [
      WatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveTvWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit WatchlistStatusChanged when event RemoveWatchList successfully',
    build: () {
      when(mockRemoveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchList(testTvDetail)),
    expect: () => [
      WatchlistStatusChanged(false),
    ],
    verify: (bloc) {
      verify(mockRemoveTvWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit WatchlistError when event RemoveWatchList unsuccessfull',
    build: () {
      when(mockRemoveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchList(testTvDetail)),
    expect: () => [
      WatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveTvWatchlist.execute(testTvDetail));
    },
  );
}
