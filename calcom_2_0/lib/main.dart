import 'package:calcom_2_0/Model/carro.dart';
import 'package:calcom_2_0/Model/destino.dart';
import 'package:calcom_2_0/Model/combustivel.dart';
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

  List<carro> listCarro = [carro(nome: 'Vectra', autonomia: 2.0)];
  List<destino> listDestino = [destino(nomeDestino: 'POA', distancia: 500)];
  List<combustivel> listCombustivel = [
    combustivel(preco: 5.4, data: DateTime(2024, 12, 22), tipo: 'Diesel')
  ];

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
      Menucalculo(
        listCarro: listCarro,
        listDestino: listDestino,
        listPreco: listCombustivel,
      ),
      Menucarro(listCarro: listCarro),
      Menudestino(listDestino: listDestino),
      Menucombustivel(listCombustivel: listCombustivel)
    ];
  }

  Widget _reloadPage(int index) {
    switch (index) {
      case 0:
        return Menucalculo(
          listCarro: listCarro,
          listDestino: listDestino,
          listPreco: listCombustivel,
        );
      case 1:
        return Menucarro(listCarro: listCarro); // Recarrega a Page2
      case 2:
        return Menudestino(listDestino: listDestino); // Recarrega a Page3
      case 3:
        return Menucombustivel(listCombustivel: listCombustivel);
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
        title: const Center(
          child: Text(
            'Cálculo de Combustível',
            style: TextStyle(
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
