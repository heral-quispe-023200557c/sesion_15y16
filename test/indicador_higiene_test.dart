import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:sesion_15y16/models/indicador_higiene.dart';
import 'package:sesion_15y16/services/higiene_api_service.dart';
void main() {
  const String respuestaJsonValida = '''
  {
    "value": [
      {
        "IndicatorCode": "WSH_HYGIENE_BASIC",
        "SpatialDim": "PER",
        "TimeDim": 2009,
        "Dim1": "RESIDENCEAREATYPE_RUR",
        "NumericValue": 46.995566574
      },
      {
        "IndicatorCode": "WSH_HYGIENE_BASIC",
        "SpatialDim": "PER",
        "TimeDim": 2024,
        "Dim1": "RESIDENCEAREATYPE_RUR",
        "NumericValue": 72.273238897
      }
    ]
  }
  ''';

  group('Pruebas de HigieneApiService con MockClient', () {
    test('Retorna lista de indicadores ordenada cuando el status es 200', () async {
      final clienteMock = MockClient((http.Request request) async {
        expect(request.url.host, 'ghoapi.azureedge.net');
        expect(request.url.queryParameters[r'$filter'], "SpatialDim eq 'PER'");
        return http.Response(respuestaJsonValida, 200);
      });

      final servicio = HigieneApiService(cliente: clienteMock);
      final List<IndicadorHigiene> resultados = await servicio.obtenerIndicadoresPeru();

      expect(resultados.length, equals(2));
      expect(resultados.first.anio, equals(2009));
      expect(resultados.last.anio, equals(2024));
      expect(resultados.last.valorTexto, equals('72.3%'));
    });

    test('Lanza ApiException cuando el servidor responde con error 404', () async {
      final clienteMock = MockClient((_) async => http.Response('Not Found', 404));
      final servicio = HigieneApiService(cliente: clienteMock);

      expect(
        () async => await servicio.obtenerIndicadoresPeru(),
        throwsA(isA<ApiException>()),
      );
    });
  });
}