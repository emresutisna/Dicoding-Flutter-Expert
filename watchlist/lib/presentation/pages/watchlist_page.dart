import 'package:watchlist/presentation/widgets/movie_watchlist.dart';
import 'package:watchlist/presentation/widgets/tv_watchlist.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: controller,
          //source code lanjutan
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.movie),
              text: "Movies",
            ),
            Tab(
              icon: Icon(Icons.tv),
              text: "TV Series",
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: kBottomNavigationBarHeight / 2),
        child: TabBarView(
          controller: controller,
          children: <Widget>[MovieWatchlist(), TvWatchlist()],
        ),
      ),
    );
  }
}
