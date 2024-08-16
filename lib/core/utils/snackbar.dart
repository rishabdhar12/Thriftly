import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {String? message}) {
  final snackBar = SnackBar(
    content: Text(message!),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
