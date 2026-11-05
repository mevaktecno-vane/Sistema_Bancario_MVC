# 🏦 Capital Bank - Sistema de Gestión Integrado (Arquitectura MVC)

Este repositorio contiene la refactorización arquitectónica del sistema bancario **Capital Bank**, migrando de una estructura monolítica a un patrón **Modelo-Vista-Controlador (MVC)** desacoplado en Python y Flet, validado mediante pruebas automatizadas con `pytest`.

---

## 📐 Estructura del Proyecto

El código fuente ha sido físicamente redistribuido en el directorio raíz respetando el aislamiento de responsabilidades:

```text
sistema_bancario_mvc/
├── src/
│   ├── models/            # Domain Models (Python Puro: Persona, Cliente, Cuenta, etc.)
│   ├── persistencia/      # Data Access Layer (SQLAlchemy ORM & DAO Pattern)
│   ├── controllers/       # Controller Layer (Mediadores y orquestadores de negocio)
│   └── views/             # View Layer (Interfaces gráficas reactivas con Flet)
├── tests/                 # Suite de pruebas unitarias e integración con pytest
├── main.py                # Punto de entrada / Interruptor general de la app
├── conftest.py            # Fixtures de base de datos en memoria para testing
└── README.md

🛡️ Especificaciones Técnicas y Reglas de Aislamiento
Para asegurar la mantenibilidad, escalabilidad y testeabilidad del software, se implementaron estrictamente tres capas autónomas:

1. Capa de Modelo (src/models/ y src/persistencia/)
Dominio Puro (src/models/): Contiene las clases Persona, Cliente, Cuenta, CuentaAhorro y Transaccion. Alberga las reglas de negocio (algoritmos de saldos, validaciones de dominio).

Persistencia (src/persistencia/): Mapeo relacional (models.py con SQLAlchemy) y patrón de acceso a datos (dao.py). Abstrae la base de datos física (SQLite) y en memoria (:memory:).

Regla de Aislamiento Estricto: Prohibición absoluta de import flet o cualquier dependencia de la interfaz gráfica.

2. Capa de Control (src/controllers/)
Contiene los mediadores orquestadores (autenticacion.py, navegacion.py).

Intercepta las acciones de la interfaz visual, procesa los parámetros, invoca a la capa de Modelo/DAO y gestiona transacciones.

Envuelve las operaciones dentro de bloques try/except para capturar alertas de negocio (ej. SaldoInsuficienteError) y guiar la mutación reactiva sin colapsar la aplicación.

3. Capa de Vista (src/views/)
Interfaces visuales desarrolladas con Flet (login.py, sesion.py, vista_gestion_clientes.py).

Su función es estrictamente renderizar la interfaz y capturar eventos de usuario (on_click).

Regla de Aislamiento Estricto: Prohibido realizar cálculos matemáticos de saldos, reglas de negocio o consultas SQL directas dentro de la UI.

🧪 Pruebas Automatizadas (Testing Headless)
Gracias al estricto desacoplamiento de la capa de Modelo respecto a la interfaz visual, la lógica del sistema y el acceso a datos pueden ser auditados de manera 100% automatizada en modo headless (sin levantar la interfaz gráfica).

Resultados de la Suite de Pruebas:
Estado: 44 PASSED, 3 SKIPPED (47 tests recolectados).

Cobertura: Pruebas unitarias de dominio (test_cliente.py, test_cuenta.py, test_transaccion.py), persistencia (test_dao_schema.py) y controladores (test_autenticacion.py).

Ejecución de Tests:
Para correr la suite de pruebas completa en la terminal, asegurate de tener activo el entorno virtual y ejecutá:
pytest