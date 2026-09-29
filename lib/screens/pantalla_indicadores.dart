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
  late Future<List<IndicadorHigiene>> _futuroIndicadores;

  @override
  void initState() {
    super.initState();
    _servicio = HigieneApiService();
    _futuroIndicadores = _servicio.obtenerIndicadoresPeru();
  }

  @override
  void dispose() {
    _servicio.cerrar();
    super.dispose();
  }

  Future<void> _recargar() async {
    setState(() {
      _futuroIndicadores = _servicio.obtenerIndicadoresPeru();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contexto Nacional (OMS)'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _recargar,
            tooltip: 'Actualizar datos',
          ),
        ],
      ),
      body: FutureBuilder<List<IndicadorHigiene>>(
        future: _futuroIndicadores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const EstadoCarga();
          }

          if (snapshot.hasError) {
            return EstadoError(
              mensaje: '${snapshot.error}',
              alReintentar: _recargar,
            );
          }

          final List<IndicadorHigiene> datos =
              snapshot.data ?? const <IndicadorHigiene>[];

          if (datos.isEmpty) {
            return const EstadoVacio();
          }

          return RefreshIndicator(
            onRefresh: _recargar,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: datos.length,
              itemBuilder: (context, index) {
                final IndicadorHigiene item = datos[index];
                return TarjetaIndicador(
                  indicador: item,
                  onTap: () {
                    context.push(
                      '/indicadores/${item.anio}',
                      extra: item,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}