import 'package:ditonton/presentation/widgets/movie_watchlist.dart';
import 'package:ditonton/presentation/widgets/tv_watchlist.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
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
        title: Text('Watchlist'),
        bottom: new TabBar(
          controller: controller,
          //source code lanjutan
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.movie),
              text: "Movies",
            ),
            new Tab(
              icon: new Icon(Icons.tv),
              text: "TV Series",
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: kBottomNavigationBarHeight / 2),
        child: new TabBarView(
          controller: controller,
          children: <Widget>[MovieWatchlist(), TvWatchlist()],
        ),
      ),
    );
  }
}
