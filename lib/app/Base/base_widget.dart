// ignore_for_file: prefer_const_constructors_in_immutables, file_names, must_be_immutable
import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget with RouteAware {
  final String r; // Routes Name
  final dynamic a; // Analytics
  final dynamic o; // Observer

  BaseWidget({key, required this.o, required this.a, required this.r}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw true;
  }
}
