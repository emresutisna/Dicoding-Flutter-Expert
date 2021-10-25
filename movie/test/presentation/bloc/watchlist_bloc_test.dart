import 'package:core/data/models/movie_model.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/watchlist_bloc.dart';
import 'package:watchlist/watchlist.dart';
import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistBloc = WatchlistBloc(
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, WatchlistInitial());
  });

  final tId = 557;

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit WatchlistStatusChanged when event LoadWatchListStatus successfully',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);

      return watchlistBloc;
    },
    act: (bloc) => bloc.add(LoadWatchListStatus(tId)),
    expect: () => [
      WatchlistStatusChanged(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit WatchlistStatusChanged when event AddToWatchList successfully',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(AddToWatchList(testMovieDetail)),
    expect: () => [
      WatchlistStatusChanged(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit WatchlistError when event AddToWatchList unsuccessfull',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(AddToWatchList(testMovieDetail)),
    expect: () => [
      WatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit WatchlistStatusChanged when event RemoveWatchList successfully',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchList(testMovieDetail)),
    expect: () => [
      WatchlistStatusChanged(false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit WatchlistError when event RemoveWatchList unsuccessfull',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveWatchList(testMovieDetail)),
    expect: () => [
      WatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
