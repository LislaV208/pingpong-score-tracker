import 'package:flutter/material.dart';

bool isBottomPadding(BuildContext context) =>
    MediaQuery.of(context).padding.bottom > 0;

Size screenSize(BuildContext context) => MediaQuery.of(context).size;

double screenRatio(BuildContext context) {
  final size = screenSize(context);

  return size.width / size.height;
}

bool isWideScreen(BuildContext context) => screenRatio(context) >= 2;
