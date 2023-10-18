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
  int totalDias = 0;
  int presenca = 0;
  int falta = 0;
  bool dataLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
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
      showSnackBar('Você ainda não teve nenhuma aula');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300, // Defina a altura desejada para o gráfico
          child: dataLoaded
              ? AspectRatio(
                  aspectRatio: 1.5,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: presenca.toDouble(),
                          title: '${((presenca / totalDias) * 100).toStringAsFixed(2)} %',
                          color: const Color.fromARGB(255, 49, 120, 51),
                        ),
                        PieChartSectionData(
                          value: falta.toDouble(),
                          title: '${((falta / totalDias) * 100).toStringAsFixed(2)} %',
                          color: const Color.fromARGB(255, 161, 40, 32),
                        ),
                      ],
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        const SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Presença',
                    style: TextStyle(
                        color: Color.fromARGB(255, 49, 120, 51), fontSize: 20)),
                Text(presenca.toString(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 49, 120, 51), fontSize: 50))
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Faltas',
                    style: TextStyle(
                        color: Color.fromARGB(255, 161, 40, 32), fontSize: 20)),
                Text(falta.toString(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 161, 40, 32), fontSize: 50))
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Total de dias',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 41, 65, 1), fontSize: 20)),
                Text(totalDias.toString(),
                    style: const TextStyle(
                        color: Color.fromRGBO(13, 41, 65, 1), fontSize: 50))
              ],
            )
          ],
        ),
      ],
    );
  }
}
