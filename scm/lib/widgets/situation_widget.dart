import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:scm/Models/situacao_model.dart';
import 'package:scm/Models/user_model.dart';
import 'package:scm/Widgets/user_widget.dart';
import 'package:scm/repositories/user_repository.dart';

class SituationWidget extends StatefulWidget {
  const SituationWidget({Key? key}) : super(key: key);

  @override
  State<SituationWidget> createState() => _SituationWidgetState();
}

class _SituationWidgetState extends State<SituationWidget> {
  List<Map<String, dynamic>> dadosDaAPI = [];
  int totalDias = 0;
  int presenca = 0;
  int falta = 0;

  @override
  void initState() {
    super.initState();
    
    // WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) { 
    //   fetchData(context);
    // });
    //fetchData(); // Chame o método fetchData ao iniciar o widget
  }

  Future<void> fetchData(context) async {
    UserModel currentUser = UserWidget.of(context)?.user ?? UserModel(email: "", senha: "");
    print(currentUser);

    List situacoes = await UserRepository.getSituation(currentUser.email);
    print(situacoes);
    if (situacoes.isNotEmpty) {
      situacoes = situacoes.where((situacao) => situacao != null).toList().cast<SituacaoModel>();
      
      for (var registro in situacoes) {
        print(registro);
        if (registro['checagem_escola'] == 1 && registro['checagem_sala'] == 1) {
          presenca++;
        } else if (registro['checagem_escola'] == 0) {
          falta++;
        }
        totalDias++;
      }
    } else {
      // const snackBar = SnackBar(
      //   content: Text('Você não esteve em nenhuma aula ainda.'),
      // );

      // // ignore: use_build_context_synchronously
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {
    fetchData(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1.5, // Proporção do gráfico
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: presenca.toDouble(),
                    title: 'Presença',
                    color: Colors.green, // Cor para a presença
                  ),
                  PieChartSectionData(
                    value: falta.toDouble(),
                    title: 'Falta',
                    color: Colors.red, // Cor para a falta
                  ),
                ],
                sectionsSpace: 0,
                centerSpaceRadius: 40, // Raio do centro do gráfico
              ),
            ),
          ),
        ],
      ),
    );
  }
}
