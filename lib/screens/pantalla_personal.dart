import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PantallaPersonal extends StatelessWidget {
  const PantallaPersonal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Auditado')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => context.go('/oportunidades'),
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Ir a Oportunidades'),
        ),
      ),
    );
  }
}