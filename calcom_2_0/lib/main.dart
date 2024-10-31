import 'package:calcom_2_0/historicoMenu.dart';
import 'package:calcom_2_0/menuCalculo.dart';
import 'package:calcom_2_0/menuCarro.dart';
import 'package:calcom_2_0/menuCombustivel.dart';
import 'package:calcom_2_0/menuDestino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cálculo de Combustível',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
      _paginas[index] = _reloadPage(index);
    });
  }

  static late List<Widget> _paginas = <Widget>[];

  @override
  void initState() {
    super.initState();
    _paginas = [
      Menucalculo(),
      Menucarro(),
      Menudestino(),
      Menucombustivel(),
      historicoMenu()
    ];
  }

  String _nomePag = 'Cálculo de Combustível';

  Widget _reloadPage(int index) {
    switch (index) {
      case 0:
        setState(() {
          _nomePag = 'Cálculo de Combustível';
        });
        return Menucalculo();
      case 1:
        setState(() {
          _nomePag = 'Veículos';
        });
        return Menucarro();
      case 2:
      setState(() {
          _nomePag = 'Destinos';
        });
        return Menudestino();
      case 3:
      setState(() {
          _nomePag = 'Combustível';
        });
        return Menucombustivel();
      case 4:
      setState(() {
          _nomePag = 'Histórico de Cálculos';
        });
        return historicoMenu();
      default:
        return const SnackBar(
          content: Text('Erro, Widget não encontrado'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _nomePag,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 16, 55, 92),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 235, 131, 23),
      ),
      body: IndexedStack(
        index: _index,
        children: _paginas,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: 'Calcular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash_outlined),
            label: 'Veículo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Destino',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_outlined),
            label: 'Combustível',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
        ],
        currentIndex: _index,
        backgroundColor: const Color.fromARGB(255, 235, 131, 23),
        unselectedItemColor: const Color.fromARGB(255, 235, 131, 23),
        selectedItemColor: const Color.fromARGB(255, 16, 55, 92),
        onTap: _onItemTapped,
      ),
    );
  }
}
