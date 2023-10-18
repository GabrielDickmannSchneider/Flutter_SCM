import 'package:flutter/material.dart';
import 'package:scm/screens/login.dart';
import 'package:scm/widgets/user_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(), // Define a tela inicial como a tela de login
      ),
    );
  }
}
