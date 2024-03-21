import 'package:flutter/material.dart';

class SelectedRoleScreenBackground extends StatelessWidget {
  const SelectedRoleScreenBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.deepPurpleAccent, Colors.white70],
          begin: Alignment.bottomCenter,
          end: Alignment.center)
          .createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/repetiteur6.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                ColorFilter.mode(Colors.blue, BlendMode.darken))),
      ),
    );
  }
}