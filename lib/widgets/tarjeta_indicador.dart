import 'package:flutter/material.dart';
import '../models/indicador_higiene.dart';

class TarjetaIndicador extends StatelessWidget {
  final IndicadorHigiene indicador;
  final VoidCallback onTap;

  const TarjetaIndicador({
    super.key,
    required this.indicador,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Año ${indicador.anio}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              indicador.valorTexto,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 4),
            Text('Ámbito: ${indicador.ambito}'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: indicador.fraccion,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}