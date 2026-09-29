# ManosSeguras — Monitoreo de Higiene de Manos

Aplicación móvil desarrollada en **Flutter** para la gestión y monitoreo de la higiene de manos en centros de salud. El proyecto incluye flujo de navegación por rutas declarativas, manejo asíncrono de estados y consumo de la API REST oficial de la Organización Mundial de la Salud (OMS / WHO) para consultar indicadores de acceso a agua y jabón en Perú.

---

## 🚀 Características Principales

- **Navegación con `go_router`:** Rutas estáticas e infinitas/dinámicas con paso de argumentos (`/`, `/establecimiento`, `/personal`, `/oportunidades`, `/indicadores`, `/indicadores/:anio`).
- **Integración con API REST:** Consumo asíncrono de datos abiertos de la OMS mediante la librería `http`.
- **Gestión de Estados en UI:** Control de interfaz asíncrona mediante `FutureBuilder` soportado por widgets dinámicos (`EstadoCarga`, `EstadoError`, `EstadoVacio`).
- **Pruebas Unitarias:** Cobertura de servicio HTTP utilizando `MockClient` (`flutter_test`) para simular respuestas del servidor (200 OK y 404 Not Found).
- **Manejo de Errores y Timeouts:** Resiliencia en peticiones de red con excepciones personalizadas (`ApiException`).

---

## 🛠️ Tecnologías Utilizadas

- **Lenguaje:** Dart
- **Framework:** Flutter (SDK `>=3.0.0 <4.0.0`)
- **Librerías principales:**
  - `go_router`: ^17.5.0
  - `http`: ^1.5.0
  - `flutter_test` / `http/testing` (Dev)

---

## 📂 Estructura del Proyecto

```text
lib/
├── models/
│   └── indicador_higiene.dart        # Modelo de datos con serialización JSON
├── router/
│   └── app_router.dart              # Configuración global de GoRouter
├── screens/
│   ├── pantalla_bienvenida.dart       # Inicio de la aplicación
│   ├── pantalla_establecimiento.dart  # Formulario de datos del establecimiento
│   ├── pantalla_personal.dart         # Selección de personal auditado
│   ├── pantalla_oportunidades.dart    # Registro de oportunidades de higiene
│   ├── pantalla_indicadores.dart      # Lista de datos OMS (FutureBuilder)
│   └── pantalla_indicador_detalle.dart# Detalle de indicador por año
├── services/
│   └── higiene_api_service.dart     # Cliente HTTP y consumo de API OMS
└── widgets/
    ├── estados_vista.dart           # Componentes para Carga, Error y Vacío
    └── tarjeta_indicador.dart       # Item reutilizable para listas
test/
└── indicador_higiene_test.dart      # Pruebas unitarias de consumo de la API