import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/indicador_higiene.dart';

class ApiException implements Exception {
  final String mensaje;
  const ApiException(this.mensaje);

  @override
  String toString() => mensaje;
}

class HigieneApiService {
  final http.Client _cliente;

  // Constructor con parámetro opcional necesario para los unit tests con MockClient
  HigieneApiService({http.Client? cliente}) : _cliente = cliente ?? http.Client();

  static const Duration tiempoLimite = Duration(seconds: 15);

  Uri get urlIndicadores => Uri.parse(
        'https://ghoapi.azureedge.net/api/WSH_HYGIENE_BASIC?\$filter=SpatialDim eq \'PER\'',
      );

  Future<List<IndicadorHigiene>> obtenerIndicadoresPeru() async {
    try {
      final http.Response respuesta = await _cliente.get(
        urlIndicadores,
        headers: const <String, String>{
          'Accept': 'application/json',
        },
      ).timeout(tiempoLimite);

      if (respuesta.statusCode != 200) {
        throw ApiException(
          'Error del servidor HTTP ${respuesta.statusCode}.',
        );
      }

      final dynamic decodificado = jsonDecode(utf8.decode(respuesta.bodyBytes));

      if (decodificado is! Map<String, dynamic>) {
        throw const ApiException('Respuesta de red con formato JSON no válido.');
      }

      final List<dynamic> crudos =
          decodificado['value'] as List<dynamic>? ?? const <dynamic>[];

      final List<IndicadorHigiene> indicadores = crudos
          .whereType<Map<String, dynamic>>()
          .map(IndicadorHigiene.fromJson)
          .toList()
        ..sort((a, b) => a.anio.compareTo(b.anio));

      return indicadores;
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(
        'La consulta superó el tiempo límite de espera. Intente nuevamente.',
      );
    } on http.ClientException {
      throw const ApiException(
        'No hay conexión a Internet o el servidor no responde.',
      );
    } catch (e) {
      throw ApiException('Error inesperado: $e');
    }
  }

  void cerrar() => _cliente.close();
}