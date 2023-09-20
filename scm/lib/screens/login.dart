import 'package:flutter/material.dart';
import 'package:scm/Models/user_model.dart';
import 'package:scm/Widgets/login_form.dart';
import 'package:scm/Widgets/user_widget.dart';
import 'package:scm/repositories/user_repository.dart';
import 'package:scm/Screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  bool loginFailed = false;

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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 238, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginForm(
              userController: userController,
              senhaController: senhaController,
              formKey: formKey,
              espacoBordas: 50,
              espacoEntreComponentes: 20,
              filho: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  Widget filhoBotao = Container();

                  if (animation.value >= 350) {
                    filhoBotao = const Text(
                      "Login",
                      style: TextStyle(color: Color.fromRGBO(234, 238, 255, 1)),
                    );
                  }

                  if (animation.value <= 150) {
                    filhoBotao = const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(234, 238, 255, 1),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 50,
                    width: animation.value,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          UserRepository.getUsers(UserModel(
                              email: userController.text, 
                              senha: senhaController.text
                          )).then((value) {
                            if (value.email.isNotEmpty) {
                              UserWidget.of(context)!.currentUser = value;

                              animationController.forward();

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            } else {
                              setState(() {
                                loginFailed = true;
                                Future.delayed(
                                    const Duration(seconds: 5), clearError);
                              });
                            }
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(10, 34, 57, 1)),
                      ),
                      child: filhoBotao,
                    ),
                  );
                },
              ),
            ),
            if (loginFailed)
              const Text(
                "Credenciais inválidas. Por favor, tente novamente.",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  void clearError() {
    setState(() {
      loginFailed = false;
    });
  }
}
