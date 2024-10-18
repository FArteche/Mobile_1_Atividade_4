import 'dart:async';

import 'package:calcom_2_0/Model/destino.dart';
import 'package:calcom_2_0/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Menudestino extends StatefulWidget {
  List<destino> listDestino;

  Menudestino({
    required this.listDestino,
  });

  @override
  State<Menudestino> createState() => _MenudestinoState();
}

class _MenudestinoState extends State<Menudestino> {
  final StreamController<List<destino>> _streamController =
      StreamController<List<destino>>();

  final controllerNomeDestino = TextEditingController();
  final controllerDistancia = TextEditingController();

  @override
  void initState() {
    super.initState();
    _streamController.add(widget.listDestino);
  }

  void __addNovoItem(String nomeDestino, double distancia) {
    setState(() {
      widget.listDestino
          .add(destino(nomeDestino: nomeDestino, distancia: distancia));
      _streamController.add(widget.listDestino);
    });
  }

  void __removeItem(int index) {
    setState(() {
      widget.listDestino.removeAt(index);
      _streamController.add(widget.listDestino);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 16, 55, 92),
      ),
      child: Center(
        child: SizedBox(
          child: Center(
            child: StreamBuilder<List<destino>>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.listDestino.length,
                        itemBuilder: (context, index) {
                          return CardD(
                            nomeDestino: widget.listDestino[index].nomeDestino,
                            distancia: widget.listDestino[index].distancia,
                            onRemove: () => __removeItem(index),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                            child: FloatingActionButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 500,
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 254, 186),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(30.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              const Text(
                                                'Adicionar Destino',
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child: TextField(
                                                  controller:
                                                      controllerNomeDestino,
                                                  decoration:
                                                      const InputDecoration(
                                                    fillColor: Color.fromARGB(
                                                        255, 253, 180, 101),
                                                    filled: true,
                                                    labelText:
                                                        'Local de destino',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child: TextField(
                                                  controller:
                                                      controllerDistancia,
                                                  decoration:
                                                      const InputDecoration(
                                                    fillColor: Color.fromARGB(
                                                        255, 253, 180, 101),
                                                    filled: true,
                                                    labelText:
                                                        'Distância (Em KM)',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d+(\.\d*)?')),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(30.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: FloatingActionButton(
                                                    onPressed: () {
                                                      if (controllerNomeDestino
                                                          .text.isNotEmpty) {
                                                        __addNovoItem(
                                                            controllerNomeDestino
                                                                .text,
                                                            double.parse(
                                                                controllerDistancia
                                                                    .text));
                                                        controllerNomeDestino
                                                            .clear();
                                                        controllerDistancia
                                                            .clear();
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 235, 131, 23),
                                                    child:
                                                        const Text('Confirmar'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 254, 186),
                              child: const Text("Adicionar destino"),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close(); // Fecha o stream quando o widget for descartado
    super.dispose();
  }
}
