import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_bloc.dart';

class MovieWatchlist extends StatefulWidget {
  @override
  _MovieWatchlistState createState() => _MovieWatchlistState();
}

class _MovieWatchlistState extends State<MovieWatchlist> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchlistMovieBloc>(context, listen: false)
          ..add(FetchWatchlistMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieHasData) {
            if (state.result.isEmpty) {
              return const Center(
                  child: Text(
                "There's no watchlist yet",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ));
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            }
          } else if (state is WatchlistMovieError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Unknown'),
            );
          }
        },
      ),
    );
  }
}
