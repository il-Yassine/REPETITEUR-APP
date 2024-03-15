import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PageNavigator {
  PageNavigator({this.ctx});

  BuildContext? ctx;

  //Navigation to next page
  Future nextPage({Widget? page}) {
    return Navigator.push(
        ctx!, CupertinoPageRoute(builder: (context) => page!));
  }

  void nextPageOnly({Widget? page}) {
    Navigator.pushAndRemoveUntil(
        ctx!, CupertinoPageRoute(builder: (context) => page!), (route) => false);
  }
}
