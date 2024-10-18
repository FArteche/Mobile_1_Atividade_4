import 'dart:async';

import 'package:calcom_2_0/Model/combustivel.dart';
import 'package:calcom_2_0/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Menucombustivel extends StatefulWidget {
  List<combustivel> listCombustivel;

  Menucombustivel({
    required this.listCombustivel,
  });

  @override
  State<Menucombustivel> createState() => _MenucombustivelState();
}

class _MenucombustivelState extends State<Menucombustivel> {
  final StreamController<List<combustivel>> _streamController =
      StreamController<List<combustivel>>();

  final controllerTipo = TextEditingController();
  final controllerPreco = TextEditingController();
  final controllerdata = TextEditingController();
  DateTime dataSelecionada = DateTime.now();

  Future<void> _selectData(BuildContext context) async {
    final DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (dataEscolhida != null && dataEscolhida != dataSelecionada) {
      setState(() {
        dataSelecionada = dataEscolhida;
        controllerdata.text = DateFormat('dd-MM-yyyy').format(dataEscolhida);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _streamController.add(widget.listCombustivel);
  }

  void __addNovoItem(double preco, DateTime data, String tipo) {
    setState(() {
      widget.listCombustivel
          .add(combustivel(preco: preco, data: data, tipo: tipo));
      _streamController.add(widget.listCombustivel);
    });
  }

  void __removeItem(int index) {
    setState(() {
      widget.listCombustivel.removeAt(index);
      _streamController.add(widget.listCombustivel);
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
            child: StreamBuilder<List<combustivel>>(
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
                        itemCount: widget.listCombustivel.length,
                        itemBuilder: (context, index) {
                          return CardCo(
                            data: widget.listCombustivel[index].data,
                            tipo: widget.listCombustivel[index].tipo,
                            preco: widget.listCombustivel[index].preco,
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
                                                'Adicionar Combustível',
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child: TextField(
                                                  controller: controllerTipo,
                                                  decoration:
                                                      const InputDecoration(
                                                    fillColor: Color.fromARGB(
                                                        255, 253, 180, 101),
                                                    filled: true,
                                                    labelText:
                                                        'Tipo do Combustível',
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
                                                  controller: controllerPreco,
                                                  decoration:
                                                      const InputDecoration(
                                                    fillColor: Color.fromARGB(
                                                        255, 253, 180, 101),
                                                    filled: true,
                                                    labelText:
                                                        'Preço do combustível no dia',
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
                                              const SizedBox(height: 10,),
                                              SizedBox(
                                                width: 300,
                                                child: TextField(
                                                  controller: controllerdata,
                                                  decoration:
                                                      const InputDecoration(
                                                    fillColor: Color.fromARGB(
                                                        255, 253, 180, 101),
                                                    filled: true,
                                                    labelText:
                                                        'Selecione o dia',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                  readOnly: true,
                                                  onTap: () => _selectData(context ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(30.0),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: FloatingActionButton(
                                                    onPressed: () {
                                                      if (controllerTipo
                                                          .text.isNotEmpty) {
                                                        __addNovoItem(double.parse(controllerPreco.text), dataSelecionada, controllerTipo.text);
                                                        controllerPreco
                                                            .clear();
                                                        controllerTipo
                                                            .clear();
                                                            controllerdata.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
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
                              child: const Text("Adicionar Combustível"),
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
