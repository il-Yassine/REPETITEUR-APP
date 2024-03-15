import 'package:flutter/material.dart';

class AppMargin extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final Widget? child;

  const AppMargin(
      {Key? key, this.margin = const EdgeInsets.all(12.0), this.child})
      : super(key: key);

  const AppMargin.allTiny(
      {Key? key, this.margin = const EdgeInsets.all(5), this.child});

  const AppMargin.allSmall(
      {Key? key, this.margin = const EdgeInsets.all(12), this.child});

  const AppMargin.allRegular(
      {Key? key, this.margin = const EdgeInsets.all(18), this.child});

  const AppMargin.allMedium(
      {Key? key, this.margin = const EdgeInsets.all(20), this.child});

  const AppMargin.allLarge(
      {Key? key, this.margin = const EdgeInsets.all(50), this.child});

  const AppMargin.horizontalTiny(
      {Key? key,
      this.margin = const EdgeInsets.symmetric(horizontal: 5),
      this.child});

  const AppMargin.horizontalSmall(
      {Key? key,
      this.margin = const EdgeInsets.symmetric(horizontal: 12),
      this.child});

  const AppMargin.horizontalRegular(
      {Key? key,
      this.margin = const EdgeInsets.symmetric(horizontal: 18),
      this.child});

  const AppMargin.horizontalMedium(
      {Key? key,
      this.margin = const EdgeInsets.symmetric(horizontal: 20),
      this.child});

  const AppMargin.horizontalLarge(
      {Key? key,
      this.margin = const EdgeInsets.symmetric(horizontal: 50),
      this.child});

  const AppMargin.verticalTiny(
      {Key? key,
      this.margin = const EdgeInsets.symmetric(vertical: 5),
      this.child});

  const AppMargin.verticalSmall(
      {Key? key,
      this.margin = const EdgeInsets.symmetric(vertical: 12),
      this.child});

  const AppMargin.verticalRegular(
      {Key? key,
      this.margin = const EdgeInsets.symmetric(vertical: 18),
      this.child});

  const AppMargin.verticalMedium(
      {Key? key,
      this.margin = const EdgeInsets.symmetric(vertical: 20),
      this.child});

  const AppMargin.verticalLarge(
      {Key? key,
      this.margin = const EdgeInsets.symmetric(vertical: 50),
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: child,
    );
  }
}
