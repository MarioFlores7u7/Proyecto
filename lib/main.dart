import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Gastos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GastosScreen(),
    );
  }
}

class GastosScreen extends StatefulWidget {
  @override
  _GastosScreenState createState() => _GastosScreenState();
}

class _GastosScreenState extends State<GastosScreen> {
  List<Registro> registros = [];
  double cuenta = 0.0;

  void agregarRegistro(Registro registro) {
    setState(() {
      registros.add(registro);
      if (registro.esIngreso) {
        cuenta += registro.cantidad;
      } else {
        cuenta -= registro.cantidad;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestor de Gastos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AgregarGastoScreen(agregarRegistro)),
              );
            },
            child: Text('Agregar Gasto'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AgregarIngresoScreen(agregarRegistro)),
              );
            },
            child: Text('Agregar Ingreso'),
          ),
          SizedBox(height: 20),
          Text(
            'Cuenta: \$${cuenta.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: registros.length,
              itemBuilder: (context, index) {
                return RegistroWidget(registros[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Registro {
  final double cantidad;
  final String tipoMoneda;
  final String categoria;
  final String comentario;
  final bool esIngreso;
  final DateTime fecha;

  Registro({
    required this.cantidad,
    required this.tipoMoneda,
    required this.categoria,
    required this.comentario,
    required this.esIngreso,
    required this.fecha,
  });
}

class RegistroWidget extends StatelessWidget {
  final Registro registro;

  RegistroWidget(this.registro);

  @override
  Widget build(BuildContext context) {
    Color color = registro.esIngreso ? Colors.green : Colors.red;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cantidad: ${registro.cantidad.toStringAsFixed(2)} ${registro.tipoMoneda}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            'Categoria: ${registro.categoria}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Comentario: ${registro.comentario}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Fecha: ${DateFormat('yyyy-MM-dd HH:mm').format(registro.fecha)}',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class AgregarGastoScreen extends StatefulWidget {
  final Function(Registro) onAgregar;

  AgregarGastoScreen(this.onAgregar);

  @override
  _AgregarGastoScreenState createState() => _AgregarGastoScreenState();
}

class _AgregarGastoScreenState extends State<AgregarGastoScreen> {
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController tipoMonedaController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController comentarioController = TextEditingController();

  void agregarGasto() {
    final double cantidad = double.parse(cantidadController.text);
    final String tipoMoneda = tipoMonedaController.text;
    final String categoria = categoriaController.text;
    final String comentario = comentarioController.text;
    final DateTime fecha = DateTime.now();

    final Registro registro = Registro(
      cantidad: cantidad,
      tipoMoneda: tipoMoneda,
      categoria: categoria,
      comentario: comentario,
      esIngreso: false,
      fecha: fecha,
    );

    widget.onAgregar(registro);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Gasto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: cantidadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Cantidad'),
            ),
            TextField(
              controller: tipoMonedaController,
              decoration: InputDecoration(labelText: 'Tipo de Moneda'),
            ),
            TextField(
              controller: categoriaController,
              decoration: InputDecoration(labelText: 'Categoría'),
            ),
            TextField(
              controller: comentarioController,
              decoration: InputDecoration(labelText: 'Comentario'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: agregarGasto,
              child: Text('Agregar Gasto'),
            ),
          ],
        ),
      ),
    );
  }
}

class AgregarIngresoScreen extends StatefulWidget {
  final Function(Registro) onAgregar;

  AgregarIngresoScreen(this.onAgregar);

  @override
  _AgregarIngresoScreenState createState() => _AgregarIngresoScreenState();
}

class _AgregarIngresoScreenState extends State<AgregarIngresoScreen> {
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController tipoMonedaController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController comentarioController = TextEditingController();

  void agregarIngreso() {
    final double cantidad = double.parse(cantidadController.text);
    final String tipoMoneda = tipoMonedaController.text;
    final String categoria = categoriaController.text;
    final String comentario = comentarioController.text;
    final DateTime fecha = DateTime.now();

    final Registro registro = Registro(
      cantidad: cantidad,
      tipoMoneda: tipoMoneda,
      categoria: categoria,
      comentario: comentario,
      esIngreso: true,
      fecha: fecha,
    );

    widget.onAgregar(registro);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Ingreso'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: cantidadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Cantidad'),
            ),
            TextField(
              controller: tipoMonedaController,
              decoration: InputDecoration(labelText: 'Tipo de Moneda'),
            ),
            TextField(
              controller: categoriaController,
              decoration: InputDecoration(labelText: 'Categoría'),
            ),
            TextField(
              controller: comentarioController,
              decoration: InputDecoration(labelText: 'Comentario'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: agregarIngreso,
              child: Text('Agregar Ingreso'),
            ),
          ],
        ),
      ),
    );
  }
}
