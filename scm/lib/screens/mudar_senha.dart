import 'package:flutter/material.dart';

class MudarSenha extends StatefulWidget {
  const MudarSenha({super.key});

  @override
  State<MudarSenha> createState() => _MudarSenhaState();
}

class _MudarSenhaState extends State<MudarSenha>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  TextEditingController senhaController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation = Tween<double>(begin: 500, end: 100).animate(CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut));
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(234, 238, 255, 1),
    );
  }
}
