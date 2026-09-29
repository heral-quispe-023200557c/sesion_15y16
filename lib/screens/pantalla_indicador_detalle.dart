import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/indicador_higiene.dart';
import '../services/higiene_api_service.dart';
import '../widgets/estados_vista.dart';

class PantallaIndicadorDetalle extends StatefulWidget {
  final int anio;
  final IndicadorHigiene? indicadorInicial;

  const PantallaIndicadorDetalle({
    super.key,
    required this.anio,
    this.indicadorInicial,
  });

  @override
  State<PantallaIndicadorDetalle> createState() =>
      _PantallaIndicadorDetalleState();
}

class _PantallaIndicadorDetalleState extends State<PantallaIndicadorDetalle> {
  late final HigieneApiService _servicio;
  late Future<IndicadorHigiene?> _futuroIndicador;

  @override
  void initState() {
    super.initState();
    _servicio = HigieneApiService();
    _futuroIndicador = _cargarDatos();
  }

  @override
  void dispose() {
    _servicio.cerrar();
    super.dispose();
  }

  Future<IndicadorHigiene?> _cargarDatos() async {
    if (widget.indicadorInicial != null) {
      return widget.indicadorInicial;
    }
    final List<IndicadorHigiene> lista = await _servicio.obtenerIndicadoresPeru();
    for (final item in lista) {
      if (item.anio == widget.anio) return item;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Año ${widget.anio}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: FutureBuilder<IndicadorHigiene?>(
        future: _futuroIndicador,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const EstadoCarga();
          }

          if (snapshot.hasError) {
            return EstadoError(
              mensaje: '${snapshot.error}',
              alReintentar: () => setState(() {
                _futuroIndicador = _cargarDatos();
              }),
            );
          }

          final IndicadorHigiene? indicador = snapshot.data;

          if (indicador == null) {
            return Center(
              child: Text('No existe información para el año ${widget.anio}.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Indicador OMS: ${indicador.codigoIndicador}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      IndicadorHigiene.descripcion,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Divider(height: 32),
                    Text('País: ${indicador.pais} (Perú)'),
                    const SizedBox(height: 8),
                    Text('Año de medición: ${indicador.anio}'),
                    const SizedBox(height: 8),
                    Text('Ámbito geográfico: ${indicador.ambito}'),
                    const SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        const Text(
                          'Valor alcanzado: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          indicador.valorTexto,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}