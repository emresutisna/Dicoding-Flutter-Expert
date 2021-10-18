import 'package:core/core.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieWatchlist extends StatefulWidget {
  @override
  _MovieWatchlistState createState() => _MovieWatchlistState();
}

class _MovieWatchlistState extends State<MovieWatchlist> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WatchlistMovieNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            if (data.watchlistMovies.isEmpty) {
              return Center(
                  child: Text(
                "There's no watchlist yet",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ));
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.watchlistMovies[index];
                  return MovieCard(movie);
                },
                itemCount: data.watchlistMovies.length,
              );
            }
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
