import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamma/models/movie.dart';
import 'package:gamma/ui/common/page_view_indicator.dart';
import 'package:gamma/ui/data/data.dart';

class CoverMovies extends StatefulWidget {
  final List<Movie> movies;

  const CoverMovies({super.key, required this.movies});

  @override
  State<CoverMovies> createState() => _CoverMoviesState();
}

class _CoverMoviesState extends State<CoverMovies>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  int _currentPageIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (_currentPageIndex < widget.movies.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageViewController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: <Widget>[
              PageView.builder(
                itemBuilder: (ctx, index) {
                  return _coverSection(widget.movies[index].coverImageUrl);
                },
                itemCount: widget.movies.length,
                controller: _pageViewController,
                physics: const ClampingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: _watchNowButton(),
              ),
            ],
          ),
        ),
        PageViewIndicator(
            count: coverMovies.length, activeTab: _currentPageIndex)
      ],
    );
  }

  _watchNowButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.25 / 2),
      child: SizedBox(
        height: 48,
        child: ElevatedButton(
          onPressed: () {
            // Handle play action using _currentPageIndex
          },
          style: ButtonStyle(
              shape: const MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_arrow_rounded,
                color: Colors.black,
              ),
              Text(
                'Watch now',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _coverSection(String imageUrl) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
