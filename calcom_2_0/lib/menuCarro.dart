import 'package:calcom_2_0/Model/DAO/carroDAO.dart';
import 'package:calcom_2_0/Model/carro.dart';
import 'package:calcom_2_0/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Menucarro extends StatefulWidget {
  @override
  State<Menucarro> createState() => _MenucarroState();
}

class _MenucarroState extends State<Menucarro> {
  final carroDAO _CarroDAO = carroDAO();

  final controllerNome = TextEditingController();
  final controllerautonomia = TextEditingController();

  void __addNovoItem(String nome, double autonomia) {
    _CarroDAO.insertCarro(
      carro(nome: nome, autonomia: autonomia),
    );
  }

  void __removeItem(int idDel) {
    _CarroDAO.deleteCarro(idDel);
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
            child: StreamBuilder<List<carro>>(
              stream: _CarroDAO.getCarroStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro: ${snapshot.error}'),
                  );
                }
                final listCarro = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: listCarro.length,
                        itemBuilder: (context, index) {
                          return CardC(
                            nome: listCarro[index].nome,
                            autonomia: listCarro[index].autonomia,
                            onRemove: () => __removeItem(listCarro[index].id!),
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
                                                'Adicionar Veículo',
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              SizedBox(
                                                width: 300,
                                                child: TextField(
                                                  controller: controllerNome,
                                                  decoration:
                                                      const InputDecoration(
                                                    fillColor: Color.fromARGB(
                                                        255, 253, 180, 101),
                                                    filled: true,
                                                    labelText:
                                                        'Nome do veículo',
                                                    border:
                                                        const OutlineInputBorder(
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
                                                      controllerautonomia,
                                                  decoration:
                                                      const InputDecoration(
                                                    fillColor: Color.fromARGB(
                                                        255, 253, 180, 101),
                                                    filled: true,
                                                    labelText:
                                                        'Autonomia do veículo',
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
                                                      if (controllerNome
                                                          .text.isNotEmpty) {
                                                        __addNovoItem(
                                                            controllerNome.text,
                                                            double.parse(
                                                                controllerautonomia
                                                                    .text));
                                                        controllerNome.clear();
                                                        controllerautonomia
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
                              child: const Text("Adicionar Carro"),
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

/*   @override
  void dispose() {
    _streamController.close(); // Fecha o stream quando o widget for descartado
    super.dispose();
  } */
}
