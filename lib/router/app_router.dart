import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/indicador_higiene.dart';
import '../screens/pantalla_bienvenida.dart';
import '../screens/pantalla_establecimiento.dart';
import '../screens/pantalla_indicador_detalle.dart';
import '../screens/pantalla_indicadores.dart';
import '../screens/pantalla_oportunidades.dart';
import '../screens/pantalla_personal.dart';

class PantallaRutaInvalida extends StatelessWidget {
  const PantallaRutaInvalida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ruta no encontrada')),
      body: const Center(
        child: Text('La ruta solicitada no existe.'),
      ),
    );
  }
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const PantallaRutaInvalida(),
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
          name: 'indicador_detalle',
          builder: (context, state) {
            final anioStr = state.pathParameters['anio'] ?? '0';
            final anio = int.tryParse(anioStr) ?? 0;
            final indicador = state.extra as IndicadorHigiene?;
            return PantallaIndicadorDetalle(
              anio: anio,
              indicador: indicador,
            );
          },
        ),
      ],
    ),
  ],
);