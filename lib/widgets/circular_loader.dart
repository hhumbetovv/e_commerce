// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

@immutable
class CircularLoader extends StatelessWidget {
  CircularLoader({Key? key, this.color}) : super(key: key) {
    type = null;
  }

  factory CircularLoader.expanded({Key? key, Color? color}) {
    return CircularLoader._(key: key, type: LoaderType.expanded, color: color);
  }

  factory CircularLoader.center({Key? key, Color? color}) {
    return CircularLoader._(key: key, type: LoaderType.center, color: color);
  }
  CircularLoader._({Key? key, required this.type, this.color}) : super(key: key);

  late final LoaderType? type;
  late final Color? color;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LoaderType.expanded:
        return Expanded(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: color != null ? AlwaysStoppedAnimation<Color>(color!) : null,
            ),
          ),
        );
      case LoaderType.center:
        return Center(
          child: CircularProgressIndicator(
            valueColor: color != null ? AlwaysStoppedAnimation<Color>(color!) : null,
          ),
        );
      default:
        return CircularProgressIndicator(
          valueColor: color != null ? AlwaysStoppedAnimation<Color>(color!) : null,
        );
    }
  }
}

enum LoaderType {
  expanded,
  center,
}
