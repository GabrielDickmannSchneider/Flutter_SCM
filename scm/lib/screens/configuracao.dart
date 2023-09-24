import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scm/Models/user_model.dart';
import 'package:scm/Widgets/custom_drawer.dart';
import 'package:scm/Widgets/user_widget.dart';

class ConfiguracaoScreen extends StatefulWidget {
  const ConfiguracaoScreen({super.key});

  @override
  State<ConfiguracaoScreen> createState() => _ConfiguracaoScreenState();
}

class _ConfiguracaoScreenState extends State<ConfiguracaoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    UserModel loggedInUser = UserWidget.of(context)!.user;
    TextEditingController userName = TextEditingController(text: loggedInUser.nome);
    TextEditingController userEmail = TextEditingController(text: loggedInUser.email);
    TextEditingController userCPF = TextEditingController(text: loggedInUser.cpf);
    TextEditingController userRes = TextEditingController(text: loggedInUser.resp);
    TextEditingController userEnd = TextEditingController(text: loggedInUser.endereco);
    TextEditingController userEsc = TextEditingController(text: loggedInUser.escola);
    TextEditingController userTurma = TextEditingController(text: loggedInUser.turma);
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              // Seu código atual da parte superior da tela
              color: const Color.fromRGBO(13, 41, 65, 1),
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const Icon(Icons.menu, color: Colors.white),
                        iconSize: MediaQuery.of(context).size.height * 0.05,
                      ),
                      ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          if (sizingInformation.isDesktop) {
                            return const Text(
                              "School Check'in Management",
                              style: TextStyle(
                                color: Color.fromRGBO(234, 238, 255, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return const Text(
                              'SCM',
                              style: TextStyle(
                                color: Color.fromRGBO(234, 238, 255, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Outros conteúdos abaixo do texto (ListTile, etc.)
                ],
              ),
            ),
            Positioned(
              // Seu código atual da parte inferior da tela
              top: MediaQuery.of(context).size.height * 0.1,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(234, 238, 255, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(10, 34, 57, 1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,                        
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: const Color.fromRGBO(13, 41, 65, 1),),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.red,),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: const Color.fromRGBO(234, 238, 255, 1),
                              child: Text(
                                loggedInUser.nome[0].toUpperCase(),
                                style:  const TextStyle(
                                  fontSize: 36,
                                  color: Color.fromRGBO(13, 41, 65, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: TextFormField(
                                    controller: userName,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Nome",
                                    ),
                                    enabled: false,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: TextFormField(
                                    controller: userEmail,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "E-mail",
                                    ),
                                    enabled: false,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: TextFormField(
                                    controller: userCPF,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "CPF",
                                    ),
                                    enabled: false,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: TextFormField(
                                    controller: userRes,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Responsável",
                                    ),
                                    enabled: false,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: TextFormField(
                                    controller: userEnd,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Endereço",
                                    ),
                                    enabled: false,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: TextFormField(
                                    controller: userEsc,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Escola",
                                    ),
                                    enabled: false,
                                  ),
                                ),
                                TextFormField(
                                  controller: userTurma,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Turma",
                                  ),
                                  enabled: false,
                                ),
                              ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
