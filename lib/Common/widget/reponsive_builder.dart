import 'package:flutter/material.dart';
import 'package:meditation_app/Utils/theme.dart';

class ReponsiveBuilder extends StatelessWidget {
  const ReponsiveBuilder({
    Key? key,
    required this.portrait,
    required this.landscape,

    }): super(key: key);
  final Widget portrait;
  final Widget landscape;
  @override
  Widget build(BuildContext context) {
    return context.orientation == Orientation.portrait ? portrait : landscape;
  }
}