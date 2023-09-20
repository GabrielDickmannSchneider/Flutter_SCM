import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final double? espacoEntreComponentes;
  final double? espacoBordas;
  final Widget? filho;
  final GlobalKey<FormState> formKey;
  final TextEditingController userController;
  final TextEditingController senhaController;

  const LoginForm({
    required this.formKey,
    required this.userController,
    required this.senhaController,
    this.espacoEntreComponentes,
    this.espacoBordas,
    this.filho,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: (widget.espacoBordas ?? 0.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: widget.userController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Usuário",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "O usuário é obrigatório";
                }
                return null;
              },
            ),
            SizedBox(
              height: (widget.espacoEntreComponentes ?? 0.0),
            ),
            TextFormField(
              controller: widget.senhaController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Senha",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "A senha é obrigatória";
                }
                return null;
              },
            ),
            SizedBox(
              height: (widget.espacoEntreComponentes ?? 0.0),
            ),
            (widget.filho ?? Container()),
          ],
        ),
      ),
    );
  }
}
