import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PantallaOportunidades extends StatelessWidget {
  const PantallaOportunidades({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Oportunidades')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => context.go('/indicadores'),
          icon: const Icon(Icons.analytics),
          label: const Text('Ver Indicadores Nacionales (OMS)'),
        ),
      ),
    );
  }
}