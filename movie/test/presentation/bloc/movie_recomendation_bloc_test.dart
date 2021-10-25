import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/movie_recomendation_bloc.dart';

import 'movie_recomendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecomendationBloc movieRecomendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecomendations;

  setUp(() {
    mockGetMovieRecomendations = MockGetMovieRecommendations();
    movieRecomendationBloc = MovieRecomendationBloc(mockGetMovieRecomendations);
  });

  test('initial state should be empty', () {
    expect(movieRecomendationBloc.state, MovieRecomendationInitial());
  });

  final tId = 557;

  final tMovie = Movie(
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
  final tMovies = <Movie>[tMovie];

  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecomendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));

      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecomendation(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecomendationsHasData(tMovies),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecomendations.execute(tId));
    },
  );

  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    'Should emit [Loading, Error] when get movie recomendation is unsuccessful',
    build: () {
      when(mockGetMovieRecomendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecomendation(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecomendations.execute(tId));
    },
  );
}
