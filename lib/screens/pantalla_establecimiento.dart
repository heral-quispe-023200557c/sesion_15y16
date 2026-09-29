import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PantallaEstablecimiento extends StatelessWidget {
  const PantallaEstablecimiento({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos del Establecimiento')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => context.go('/personal'),
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Ir a Personal Salud'),
        ),
      ),
    );
  }
}