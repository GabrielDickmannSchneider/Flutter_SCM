import 'package:flutter/material.dart';
import 'package:scm/models/resp_model.dart';
import 'package:scm/screens/calendario.dart';
import 'package:scm/screens/home_resp.dart';
import 'package:scm/screens/login.dart';
import 'package:scm/widgets/resp_widget.dart';

class CustomDrawerResp extends StatelessWidget {
  const CustomDrawerResp({super.key});

  @override
  Widget build(BuildContext context) {
    RespModel loggedInResp = RespWidget.of(context)!.resp;

    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color.fromRGBO(234, 238, 255, 1),
        ),
        child: Drawer(
          // Seu código atual do drawer
          child: Column(
            children: <Widget>[
              Container(
                color: const Color.fromRGBO(13, 41, 65, 1), // Cor da faixa azul
                child: Column(
                  children: [
                    Container(
                      color: const Color.fromRGBO(13, 41, 65, 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        color: const Color.fromRGBO(13, 41, 65, 1),
                        child: Column(
                          children: [
                            if (loggedInResp.nome.isNotEmpty) // Verifica se loggedInUser está inicializado
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: const Color.fromRGBO(234, 238, 255, 1),
                                child: Text(
                                  loggedInResp.nome[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 36,
                                    color: Color.fromRGBO(13, 41, 65, 1),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 10),
                            if (loggedInResp.nome.isNotEmpty) // Verifica se loggedInUser está inicializado
                              Text(
                                loggedInResp.nome,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(234, 238, 255, 1),
                                ),
                              ),
                            if (loggedInResp.nome.isNotEmpty) // Verifica se loggedInUser está inicializado
                              Text(
                                loggedInResp.email,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(234, 238, 255, 1),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_sharp,
                    color: Color.fromRGBO(13, 41, 65, 1), size: 32),
                title: const Text('Home',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 41, 65, 1), fontSize: 20)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreenResp(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings,
                    color: Color.fromRGBO(13, 41, 65, 1), size: 32),
                title: const Text('Configurações',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 41, 65, 1), fontSize: 20)),
                onTap: () {
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => const ConfiguracaoScreen(),
                  //   ),
                  // );
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month_sharp,
                    color: Color.fromRGBO(13, 41, 65, 1), size: 32),
                title: const Text('Calendário',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 41, 65, 1), fontSize: 20)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const CalendarScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.bar_chart_sharp,
                    color: Color.fromRGBO(13, 41, 65, 1), size: 32),
                title: const Text('Situação',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 41, 65, 1), fontSize: 20)),
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const SituationScreen(),
                  //   ),
                  // );
                },
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.exit_to_app_sharp,
                    color: Color.fromRGBO(13, 41, 65, 1), size: 32),
                title: const Text('Log out',
                    style: TextStyle(
                        color: Color.fromRGBO(13, 41, 65, 1), fontSize: 20)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
  }
}