import 'package:flutter/material.dart';

class EstadoCarga extends StatelessWidget {
  final String mensaje;
  const EstadoCarga({
    super.key,
    this.mensaje = 'Descargando datos oficiales de la OMS...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(mensaje, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class EstadoError extends StatelessWidget {
  final String mensaje;
  final VoidCallback alReintentar;

  const EstadoError({
    super.key,
    required this.mensaje,
    required this.alReintentar,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.cloud_off, size: 56, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Ocurrió un problema',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(mensaje, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: alReintentar,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}

class EstadoVacio extends StatelessWidget {
  const EstadoVacio({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No se encontraron registros de higiene para la consulta.'),
    );
  }
}