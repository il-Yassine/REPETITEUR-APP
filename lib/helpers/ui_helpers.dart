import 'package:flutter/material.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 5);
const Widget horizontalSpaceMinSmall = SizedBox(width: 10);
const Widget horizontalSpaceSmall = SizedBox(width: 12);
const Widget horizontalSpaceRegular = SizedBox(width: 18);
const Widget horizontalSpaceMedium = SizedBox(width: 25);
const Widget horizontalSpaceLarge = SizedBox(width: 50);

const Widget verticalSpaceTiny = SizedBox(height: 5);
const Widget verticalSpaceSmall = SizedBox(height: 12);
const Widget verticalSpaceRegular = SizedBox(height: 18);
const Widget verticalSpaceMedium = SizedBox(height: 20);
const Widget verticalSpaceLarge = SizedBox(height: 50);

List<BoxShadow> lightShadow = [
  BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 3,
      offset: Offset(0, 1))
];

List<BoxShadow> mediumShadow = [
  BoxShadow(
      color: Colors.grey.withOpacity(0.4),
      spreadRadius: 1,
      blurRadius: 3,
      offset: Offset(0, 1))
];

List<BoxShadow> darkShadow = [
  BoxShadow(
      color: Colors.grey.withOpacity(0.6),
      spreadRadius: 1,
      blurRadius: 3,
      offset: Offset(0, 1))
];

// Screen Size helpers
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;

Offset getWidgetOffset(GlobalKey popupKey) {
  final RenderBox renderBox =
  popupKey.currentContext?.findRenderObject() as RenderBox;
  /* final Size size = renderBox.size; */
  final Offset offset = renderBox.localToGlobal(Offset.zero);
  return offset;
}

RelativeRect getWidgetPosition(GlobalKey popupKey) {
  final RenderBox renderBox =
  popupKey.currentContext?.findRenderObject() as RenderBox;
  final Size size = renderBox.size;
  final Offset offset = renderBox.localToGlobal(Offset.zero);
  return RelativeRect.fromLTRB(offset.dx, offset.dy + size.height,
      offset.dx + size.width, offset.dy + size.height);
}

Offset draggableStrategy(
    Draggable<Object> draggable, BuildContext context, Offset position) {
  return Offset(
      draggable.feedbackOffset.dx + 70, draggable.feedbackOffset.dy + 70);
}

String getIcon(String name) => 'assets/images/icons/$name.svg';
