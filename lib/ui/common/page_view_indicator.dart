import 'package:flutter/material.dart';

class PageViewIndicator extends StatelessWidget {
  const PageViewIndicator({
    required this.count,
    required this.activeTab,
    super.key,
  });

  final int count;
  final int activeTab;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 100, maxHeight: 50),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          count,
          (i) => Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: AnimatedCrossFade(
                firstChild: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(109, 109, 109, 1.0),
                    shape: BoxShape.circle,
                  ),
                  width: 6,
                  height: 6,
                ),
                secondChild: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  width: 8,
                  height: 8,
                ),
                crossFadeState: i != activeTab
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 300),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
