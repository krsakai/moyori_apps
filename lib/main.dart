import 'package:flutter/material.dart';
import 'package:moyori/application.dart';
import 'package:provider/provider.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Provider<String>.value(value: "environment", child: Application()),
  );
}
