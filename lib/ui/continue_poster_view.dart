import 'package:flutter/material.dart';
import 'package:gamma/models/movie.dart';

class ContinuePosterView extends StatelessWidget {
  final Movie movie;

  const ContinuePosterView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 220,
          width: 148,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
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
              movie.coverImageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(94, 94, 94, 0.9),
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 44,
            ),
          ),
        ),
        Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  movie.title!,
                  style: const TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor: Colors.white.withOpacity(0.38),
                    color: Colors.white,
                    value: movie.watchProgress,
                  ),
                )
              ],
            ))
      ],
    );
  }
}
