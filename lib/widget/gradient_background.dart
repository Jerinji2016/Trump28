import 'package:flutter/material.dart';
import 'package:trump28/main.dart';

class GradientBackground extends StatelessWidget {
  final Widget? child;
  final List<Color> colors;

  const GradientBackground({
    Key? key,
    this.child,
    this.colors: const [background, primary],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
        ),
      ),
      child: child,
    );
  }
}
