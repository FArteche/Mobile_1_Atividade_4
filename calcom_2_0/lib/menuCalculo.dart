import 'package:calcom_2_0/Model/carro.dart';
import 'package:calcom_2_0/Model/destino.dart';
import 'package:calcom_2_0/Model/combustivel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Menucalculo extends StatefulWidget {
  List<carro> listCarro;
  List<destino> listDestino;
  List<combustivel> listPreco;

  Menucalculo(
      {required this.listCarro,
      required this.listDestino,
      required this.listPreco});

  @override
  State<Menucalculo> createState() => _MenucalculoState();
}

class _MenucalculoState extends State<Menucalculo> {
  carro? _carroSelecionado;
  destino? _destinoSelecionado;
  combustivel? _precoSelecionado;

  double resultado = 0.0;
  String _mensagemErro = "";
  String _mensagemResultado = "";
  String _mensagemInfo1 = "";
  String _mensagemInfo2 = "";
  String _mensagemInfo3 = "";
  String _mensagemInfo4 = "";
  String _mensagemInfo5 = "";
  String _mensagemInfo6 = "";

  bool _isvisible = false;

  void alterarVisibilidade() {
    setState(() {
      _isvisible = true;
    });
  }

  void _mensagemErroBuilder() {
    _mensagemErro = "Campos não selecionados: ";
    if (_carroSelecionado == null) {
      _mensagemErro += "Veículo ";
    }
    if (_destinoSelecionado == null) {
      _mensagemErro += "Destino ";
    }
    if (_precoSelecionado == null) {
      _mensagemErro += "Combustível ";
    }
  }

  void calculo(double autonomia, double preco, double distancia) {
    resultado = (distancia / autonomia) * preco;
    _mensagemResultado = 'R\$ $resultado';
    _mensagemInfo1 = '\nVeículo: ';
    _mensagemInfo2 = '$_carroSelecionado';
    _mensagemInfo3 = '\nCombustível: ';
    _mensagemInfo4 = '$_precoSelecionado';
    _mensagemInfo5 = '\nDestino: ';
    _mensagemInfo6 = '$_destinoSelecionado';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 16, 55, 92),
      ),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: 300,
                height: 350,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 131, 23),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 3)),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15),
                      ),
                      const Text(
                        'Veículo:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 16, 55, 92),
                        ),
                      ),
                      //DROPDOWN VEÍCULO
                      Container(
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(color: Colors.black, width: 1),
                          color: const Color.fromARGB(255, 244, 246, 200),
                        ),
                        child: Center(
                          child: DropdownButton<carro>(
                            style: const TextStyle(
                              color: Color.fromARGB(255, 16, 55, 92),
                            ),
                            dropdownColor:
                                const Color.fromARGB(255, 244, 246, 200),
                            borderRadius: BorderRadius.circular(20),
                            menuWidth: 140,
                            menuMaxHeight: 300,
                            hint: const Text('Veículos'),
                            value: _carroSelecionado,
                            onChanged: (carro? novoCarro) {
                              setState(() {
                                _carroSelecionado = novoCarro;
                              });
                            },
                            items: widget.listCarro.map((carro carros) {
                              return DropdownMenuItem<carro>(
                                value: carros,
                                child: Text(carros.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      const Text(
                        'Destino:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 16, 55, 92),
                        ),
                      ),
                      //DROPDOWN DESTINO

                      Container(
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(color: Colors.black, width: 1),
                          color: const Color.fromARGB(255, 244, 246, 200),
                        ),
                        child: Center(
                          child: DropdownButton<destino>(
                            style: const TextStyle(
                              color: Color.fromARGB(255, 16, 55, 92),
                            ),
                            dropdownColor:
                                const Color.fromARGB(255, 244, 246, 200),
                            borderRadius: BorderRadius.circular(20),
                            menuWidth: 140,
                            menuMaxHeight: 300,
                            hint: const Text('Destinos'),
                            value: _destinoSelecionado,
                            onChanged: (destino? novoDestino) {
                              setState(() {
                                _destinoSelecionado = novoDestino;
                              });
                            },
                            items: widget.listDestino.map((destino destinos) {
                              return DropdownMenuItem<destino>(
                                value: destinos,
                                child: Text(destinos.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      const Text(
                        'Combustível escolhido:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 16, 55, 92),
                        ),
                      ),
                      //DROPDOWN COMBUSTÍVEL
                      Container(
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(color: Colors.black, width: 1),
                          color: const Color.fromARGB(255, 244, 246, 200),
                        ),
                        child: Center(
                          child: DropdownButton<combustivel>(
                            style: const TextStyle(
                              color: Color.fromARGB(255, 16, 55, 92),
                            ),
                            dropdownColor:
                                const Color.fromARGB(255, 244, 246, 200),
                            borderRadius: BorderRadius.circular(20),
                            menuWidth: 200,
                            menuMaxHeight: 300,
                            hint: const Text('Combustível'),
                            value: _precoSelecionado,
                            onChanged: (combustivel? novoCombustivel) {
                              setState(() {
                                _precoSelecionado = novoCombustivel;
                              });
                            },
                            items: widget.listPreco.map((combustivel precos) {
                              return DropdownMenuItem<combustivel>(
                                value: precos,
                                child: Text(precos.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      //BOTÂO CALCULAR
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 16, 55, 92),
                        ),
                        onPressed: () {
                          if (_carroSelecionado != null &&
                              _precoSelecionado != null &&
                              _destinoSelecionado != null) {
                            setState(
                              () {
                                calculo(
                                    _carroSelecionado!.autonomia,
                                    _precoSelecionado!.preco,
                                    _destinoSelecionado!.distancia);
                                alterarVisibilidade();
                              },
                            );
                          } else {
                            _mensagemErroBuilder();
                            var erronull = SnackBar(
                              content: Text(_mensagemErro),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(erronull);
                          }
                        },
                        child: const Text(
                          "Calcular",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 244, 246, 200)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Visibility(
                visible: _isvisible,
                child: SizedBox(
                  width: 500,
                  height: 250,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 131, 23),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 10, 05),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Gasto Previsto\n',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 16, 55, 92),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: _mensagemResultado,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: _mensagemInfo1,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 16, 55, 92),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: _mensagemInfo2,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),TextSpan(
                                text: _mensagemInfo3,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 16, 55, 92),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: _mensagemInfo4,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),TextSpan(
                                text: _mensagemInfo5,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 16, 55, 92),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: _mensagemInfo6,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
