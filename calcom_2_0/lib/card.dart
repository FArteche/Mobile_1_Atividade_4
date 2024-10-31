import 'package:calcom_2_0/Model/DAO/historicoDAO.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardC extends StatelessWidget {
  final String nome;
  final double autonomia;
  final Function() onRemove;

  CardC({required this.nome, required this.autonomia, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 254, 186),
      shadowColor: Colors.black45,
      elevation: 20,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Icon(Icons.car_crash_sharp),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  children: [
                    Text("Veículo: $nome"),
                    Text("Autonomia: $autonomia"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {
              onRemove();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}

class CardD extends StatelessWidget {
  final String nomeDestino;
  final double distancia;
  final Function() onRemove;

  CardD(
      {required this.nomeDestino,
      required this.distancia,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 254, 186),
      shadowColor: Colors.black45,
      elevation: 20,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  children: [
                    Text("Destino: $nomeDestino"),
                    Text("Distância: $distancia"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {
              onRemove();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}

class CardCo extends StatelessWidget {
  final DateTime data;
  final String tipo;
  final double preco;
  final Function() onRemove;

  CardCo(
      {required this.data,
      required this.tipo,
      required this.preco,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 254, 186),
      shadowColor: Colors.black45,
      elevation: 20,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Icon(Icons.water_drop_outlined),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    Text('Data: ${DateFormat('dd-MM-yyyy').format(data)}'),
                    Text("Tipo: $tipo"),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    const Text(
                      "Preço do Combustível",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("R\$ $preco"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {
              onRemove();
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}

class CardHist extends StatelessWidget {
  final int id;
  final double gasto;
  final String histComb;
  final String histVeic;
  final String histDest;

  CardHist({
    required this.id,
    required this.gasto,
    required this.histComb,
    required this.histVeic,
    required this.histDest,
  });

  final historicoDAO _HistoricoDAO = historicoDAO();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 254, 186),
      shadowColor: Colors.black45,
      elevation: 20,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Icon(Icons.history_outlined),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    Text('Combustível: $histComb'),
                    Text('Veículo: $histVeic'),
                    Text('Destino: $histDest'),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    const Text(
                      "Gasto Final:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("R\$ ${gasto.toStringAsFixed(2)}"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {
              _HistoricoDAO.deleteHistorico(id);
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}
