import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.white, Colors.white70],
          begin: Alignment.bottomCenter,
          end: Alignment.center)
          .createShader(bounds),
      blendMode: BlendMode.lighten,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/repetiteur6.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                ColorFilter.mode(Colors.white70, BlendMode.darken))),
      ),
    );
  }
}