import 'package:calcom_2_0/Model/DAO/historicoDAO.dart';
import 'package:calcom_2_0/Model/historico.dart';
import 'package:calcom_2_0/card.dart';
import 'package:flutter/material.dart';

class historicoMenu extends StatelessWidget {
  const historicoMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final historicoDAO _HistoricoDAO = historicoDAO();

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 16, 55, 92),
      ),
      child: Center(
        child: SizedBox(
          child: Center(
            child: StreamBuilder(
              stream: _HistoricoDAO.getHistoricoStream(),
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
                final listHistorico = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: listHistorico.length,
                      itemBuilder: (context, index) {
                        return CardHist(
                          id: listHistorico[index].id!,
                          gasto: listHistorico[index].gasto,
                          histComb: listHistorico[index].histComb,
                          histVeic: listHistorico[index].histVeic,
                          histDest: listHistorico[index].histDest,
                        );
                      },
                    ))
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
