
import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/styles.dart';

class AppText extends StatelessWidget {
  final String? text;
  final TextStyle style;
  final TextAlign alignment;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool handleNull;

  AppText.headingOne(this.text,
      {Color color = kcBlackColor,
      TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = heading1Style.copyWith(color: color),
        alignment = align;

  AppText.headingTwo(this.text,
      {Color color = kcBlackColor,
      TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = heading2Style.copyWith(color: color),
        alignment = align;

  AppText.headingThree(this.text,
      {Color color = kcBlackColor,
      TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = heading3Style.copyWith(color: color),
        alignment = align;

  AppText.headingFour(this.text,
      {Color color = kcBlackColor,
      TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = heading4Style.copyWith(color: color),
        alignment = align;

  AppText.headingFive(this.text,
      {Color color = kcBlackColor,
      TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = heading5Style.copyWith(color: color),
        alignment = align;

  AppText.headingSix(this.text,
      {Color color = kcBlackColor,
      TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = heading6Style.copyWith(color: color),
        alignment = align;

  const AppText.headline(this.text,
      {TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = headlineStyle,
        alignment = align;

  AppText.subheading(this.text,
      {Color color = kcDarkGreyColor,
      TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = subheadingStyle.copyWith(color: color),
        alignment = align;

  AppText.caption(this.text,
      {Color color = kcBlackColor,
      TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = captionStyle.copyWith(color: color),
        alignment = align;

  AppText.body(this.text,
      {Color color = kcDarkGreyColor,
      TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = bodyStyle.copyWith(
          color: color,
          fontSize: 16.5
        ),
        alignment = align;

  AppText.appbarTitle(this.text,
      {Color color = Colors.black,
      TextAlign align = TextAlign.start,
      this.maxLines,
      this.overflow,
      this.handleNull = false})
      : style = appbarTitleStyle.copyWith(
          color: color,
        ),
        alignment = align;

  @override
  Widget build(BuildContext context) {
    var value = '';
    if ((text == null || text == '') && handleNull) {
      value = 'N/A';
    } else {
      value = text ?? '';
    }

    return Text(
      value,
      style: style,
      textAlign: alignment,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: false,
    );
  }
}
