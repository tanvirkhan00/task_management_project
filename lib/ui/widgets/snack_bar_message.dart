import 'package:flutter/material.dart';

void showSnakbarMessage (BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message)));
}