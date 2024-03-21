import 'package:flutter/material.dart';

class AppPadding extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Widget? child;

  const AppPadding(
      {Key? key,
      this.padding = const EdgeInsets.all(12.0),
      this.backgroundColor,
      this.child})
      : super(key: key);

  const AppPadding.allTiny(
      {Key? key,
      this.padding = const EdgeInsets.all(5),
      this.backgroundColor,
      this.child});

  const AppPadding.allSmall(
      {Key? key,
      this.padding = const EdgeInsets.all(12),
      this.backgroundColor,
      this.child});

  const AppPadding.allRegular(
      {Key? key,
      this.padding = const EdgeInsets.all(18),
      this.backgroundColor,
      this.child});

  const AppPadding.allMedium(
      {Key? key,
      this.padding = const EdgeInsets.all(20),
      this.backgroundColor,
      this.child});

  const AppPadding.allLarge(
      {Key? key,
      this.padding = const EdgeInsets.all(50),
      this.backgroundColor,
      this.child});

  const AppPadding.horizontalTiny(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(horizontal: 5),
      this.backgroundColor,
      this.child});

  const AppPadding.horizontalSmall(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(horizontal: 12),
      this.backgroundColor,
      this.child});

  const AppPadding.horizontalRegular(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(horizontal: 18),
      this.backgroundColor,
      this.child});

  const AppPadding.horizontalMedium(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(horizontal: 20),
      this.backgroundColor,
      this.child});

  const AppPadding.horizontalLarge(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(horizontal: 50),
      this.backgroundColor,
      this.child});

  const AppPadding.verticalTiny(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(vertical: 5),
      this.backgroundColor,
      this.child});

  const AppPadding.verticalSmall(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(vertical: 12),
      this.backgroundColor,
      this.child});

  const AppPadding.verticalRegular(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(vertical: 18),
      this.backgroundColor,
      this.child});

  const AppPadding.verticalMedium(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(vertical: 20),
      this.backgroundColor,
      this.child});

  const AppPadding.verticalLarge(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(vertical: 50),
      this.backgroundColor,
      this.child});

  const AppPadding.ltrTiny(
      {Key? key,
      this.padding = const EdgeInsets.only(left: 5, top: 5, right: 5),
      this.backgroundColor,
      this.child});

  const AppPadding.ltrSmall(
      {Key? key,
      this.padding = const EdgeInsets.only(left: 12, top: 12, right: 12),
      this.backgroundColor,
      this.child});

  const AppPadding.ltrRegular(
      {Key? key,
      this.padding = const EdgeInsets.only(left: 18, top: 18, right: 18),
      this.backgroundColor,
      this.child});

  const AppPadding.ltrMedium(
      {Key? key,
      this.padding = const EdgeInsets.only(left: 20, top: 20, right: 20),
      this.backgroundColor,
      this.child});

  const AppPadding.ltrLarge(
      {Key? key,
      this.padding = const EdgeInsets.only(left: 50, top: 50, right: 50),
      this.backgroundColor,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
