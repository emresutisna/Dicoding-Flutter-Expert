import 'package:core/core.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/watchlist.dart';

class TvWatchlist extends StatefulWidget {
  @override
  _TvWatchlistState createState() => _TvWatchlistState();
}

class _TvWatchlistState extends State<TvWatchlist> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchlistTvBloc>(context, listen: false)
          ..add(FetchWatchlistTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
        builder: (context, state) {
          if (state is WatchlistTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvHasData) {
            if (state.result.isEmpty) {
              return const Center(
                  child: Text(
                "There's no watchlist yet",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ));
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            }
          } else if (state is WatchlistTvError) {
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
