// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:scm/models/user_model.dart';
import 'package:scm/widgets/user_widget.dart';
import 'package:scm/repositories/user_repository.dart';

class SituationWidget extends StatefulWidget {
  const SituationWidget({Key? key}) : super(key: key);

  @override
  State<SituationWidget> createState() => _SituationWidgetState();
}

class _SituationWidgetState extends State<SituationWidget> {
  double totalDias = 0;
  int presenca = 0;
  int falta = 0;
  bool dataLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void> fetchData() async {
    UserModel currentUser =
        UserWidget.of(context)?.user ?? UserModel(email: "", senha: "");

    List situacoes = await UserRepository.getSituation(currentUser.email);

    if (situacoes.isNotEmpty) {
      setState(() {
        situacoes = situacoes.where((situacao) => situacao != null).toList();

        for (var registro in situacoes) {
          if (registro.situacao == "Presença") {
            presenca++;
          } else {
            falta++;
          }
          totalDias++;
        }
        dataLoaded = true;
      });
    } else {
      const snackBar = SnackBar(
        content: Text('Você não esteve em nenhuma aula ainda.'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: dataLoaded
          ? AspectRatio(
              aspectRatio: 1.5,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: presenca.toDouble(),
                      title: 'Presença',
                      color: const Color.fromARGB(255, 49, 120, 51),
                    ),
                    PieChartSectionData(
                      value: falta.toDouble(),
                      title: 'Falta',
                      color: const Color.fromARGB(255, 161, 40, 32),
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
