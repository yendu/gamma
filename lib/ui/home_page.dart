import 'package:flutter/material.dart';
import 'package:gamma/models/movie.dart';
import 'package:gamma/ui/continue_poster_view.dart';
import 'package:gamma/ui/cover_movies/cover_movies.dart';
import 'package:gamma/ui/data/data.dart';
import 'package:gamma/ui/poster_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: CoverMovies(movies: coverMovies),
            ),
            const SizedBox(
              height: 12,
            ),
            _homePageContent(),
          ],
        ),
      ),
    );
  }

  _homePageContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePostersSection("Recently added", recentlyAddedMovies),
          _moviePostersSection("Continue watching", continueWatchingMovies,
              continueWatchingMovie: true),
          _moviePostersSection("Most watched", mostWatchedMovies),
        ],
      ),
    );
  }

  _moviePostersSection(String sectionTitle, List<Movie> movies,
      {bool continueWatchingMovie = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 230,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                if(continueWatchingMovie){
                  return ContinuePosterView(movie: movies[index]);
                }
                return PosterView(movie: movies[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemCount: movies.length,
            )),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
