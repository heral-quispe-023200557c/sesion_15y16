import 'package:flutter/material.dart';
import '../models/indicador_higiene.dart';

class PantallaIndicadorDetalle extends StatelessWidget {
  final int anio;
  final IndicadorHigiene? indicador;

  const PantallaIndicadorDetalle({
    super.key,
    required this.anio,
    this.indicador,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle Indicador $anio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: indicador != null
            ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Indicador OMS: ${indicador!.codigo}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      Text('País: ${indicador!.pais}'),
                      Text('Año de medición: ${indicador!.anio}'),
                      const SizedBox(height: 12),
                      Text(
                        'Cobertura básica: ${indicador!.valorTexto}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Text('No hay información detallada para el año $anio.'),
              ),
      ),
    );
  }
}