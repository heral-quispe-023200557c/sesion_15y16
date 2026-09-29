import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/indicador_higiene.dart';
import '../screens/pantalla_bienvenida.dart';
import '../screens/pantalla_establecimiento.dart';
import '../screens/pantalla_indicador_detalle.dart';
import '../screens/pantalla_indicadores.dart';
import '../screens/pantalla_oportunidades.dart';
import '../screens/pantalla_personal.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'bienvenida',
      builder: (context, state) => const PantallaBienvenida(),
    ),
    GoRoute(
      path: '/establecimiento',
      name: 'establecimiento',
      builder: (context, state) => const PantallaEstablecimiento(),
    ),
    GoRoute(
      path: '/personal',
      name: 'personal',
      builder: (context, state) => const PantallaPersonal(),
    ),
    GoRoute(
      path: '/oportunidades',
      name: 'oportunidades',
      builder: (context, state) => const PantallaOportunidades(),
    ),
    GoRoute(
      path: '/indicadores',
      name: 'indicadores',
      builder: (context, state) => const PantallaIndicadores(),
      routes: <RouteBase>[
        GoRoute(
          path: ':anio',
          name: 'indicadorDetalle',
          builder: (context, state) {
            final int? anio = int.tryParse(state.pathParameters['anio'] ?? '');
            if (anio == null) {
              return const PantallaRutaInvalida(
                mensaje: 'El parámetro de año proporcionado no es válido.',
              );
            }

            final IndicadorHigiene? indicador =
                state.extra is IndicadorHigiene ? state.extra as IndicadorHigiene : null;

            return PantallaIndicadorDetalle(
              anio: anio,
              indicadorInicial: indicador,
            );
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => PantallaRutaInvalida(
    mensaje: 'No existe la ruta solicitada: ${state.uri}',
  ),
);

class PantallaRutaInvalida extends StatelessWidget {
  final String mensaje;
  const PantallaRutaInvalida({super.key, required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ruta no encontrada')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.error_outline, size: 56, color: Colors.orange),
              const SizedBox(height: 16),
              Text(mensaje, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Volver al Inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}