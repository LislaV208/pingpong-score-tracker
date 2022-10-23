import 'package:flutter/material.dart';

bool isBottomPadding(BuildContext context) =>
    MediaQuery.of(context).padding.bottom > 0;

Size screenSize(BuildContext context) => MediaQuery.of(context).size;
