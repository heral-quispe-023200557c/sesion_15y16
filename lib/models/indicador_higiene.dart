class IndicadorHigiene {
  final String codigo;
  final String pais;
  final int anio;
  final double valor;

  const IndicadorHigiene({
    required this.codigo,
    required this.pais,
    required this.anio,
    required this.valor,
  });

  factory IndicadorHigiene.fromJson(Map<String, dynamic> json) {
    return IndicadorHigiene(
      codigo: json['IndicatorCode']?.toString() ?? '',
      pais: json['SpatialDim']?.toString() ?? '',
      anio: int.tryParse(json['TimeDim']?.toString() ?? '') ?? 0,
      valor: double.tryParse(json['NumericValue']?.toString() ?? '') ?? 0.0,
    );
  }

  String get valorTexto => '${valor.toStringAsFixed(1)}%';
}