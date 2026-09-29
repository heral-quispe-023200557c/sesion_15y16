import 'package:flutter/material.dart';
import 'router/app_router.dart';

void main() {
  runApp(const ManosSegurasApp());
}

class ManosSegurasApp extends StatelessWidget {
  const ManosSegurasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ManosSeguras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      routerConfig: appRouter,
    );
  }
}