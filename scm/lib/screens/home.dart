import 'package:flutter/material.dart';
import 'package:scm/Widgets/custom_drawer.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

    @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
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
                // Add your content here
              ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
