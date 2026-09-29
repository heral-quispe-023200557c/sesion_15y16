import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PantallaBienvenida extends StatelessWidget {
  const PantallaBienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ManosSeguras - Bienvenida')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => context.go('/establecimiento'),
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Ir a Establecimiento'),
        ),
      ),
    );
  }
}