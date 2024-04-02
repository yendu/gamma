import 'package:flutter/material.dart';
import 'package:gamma/models/movie.dart';

class PosterView extends StatelessWidget {
  final Movie movie;

  const PosterView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 220,
        width: 148,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          shape: BoxShape.rectangle,
          color: Colors.red
        ),
        child: Image.asset(movie.coverImageUrl,
          fit: BoxFit.cover,
          height: 220,
          width: 148,
        )
    );
  }

}