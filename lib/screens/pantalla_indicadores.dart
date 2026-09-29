import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/indicador_higiene.dart';
import '../services/higiene_api_service.dart';
import '../widgets/estados_vista.dart';
import '../widgets/tarjeta_indicador.dart';

class PantallaIndicadores extends StatefulWidget {
  const PantallaIndicadores({super.key});

  @override
  State<PantallaIndicadores> createState() => _PantallaIndicadoresState();
}

class _PantallaIndicadoresState extends State<PantallaIndicadores> {
  late final HigieneApiService _servicio;
  late Future<List<IndicadorHigiene>> _futureIndicadores;

  @override
  void initState() {
    super.initState();
    _servicio = HigieneApiService();
    _cargarDatos();
  }

  void _cargarDatos() {
    setState(() {
      _futureIndicadores = _servicio.obtenerIndicadoresPeru();
    });
  }

  @override
  void dispose() {
    _servicio.cerrar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contexto Nacional (OMS)'),
      ),
      body: FutureBuilder<List<IndicadorHigiene>>(
        future: _futureIndicadores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const EstadoCarga();
          }

          if (snapshot.hasError) {
            return EstadoError(
              mensaje: snapshot.error.toString(),
              alReintentar: _cargarDatos,
            );
          }

          final lista = snapshot.data ?? [];
          if (lista.isEmpty) {
            return const EstadoVacio();
          }

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final item = lista[index];
              return TarjetaIndicador(
                titulo: 'Año ${item.anio}',
                subtitulo: 'País: ${item.pais} | Código: ${item.codigo}',
                valor: item.valorTexto,
                onTap: () {
                  context.go(
                    '/indicadores/${item.anio}',
                    extra: item,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}