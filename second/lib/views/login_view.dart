import 'package:flutter/material.dart';
import 'package:second/controls/text_form_field_wdiget.dart';
import 'package:second/services/authentication_service.dart';
import 'package:second/widgets/snack_bar_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _form = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthenticationService _authenticationService = AuthenticationService();
  bool showPassword = false;

  void _togglePasswordView() {
    setState(() {
      showPassword = !showPassword; // Toggle the showPassword flag
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple[300],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                SizedBox(height: 10),
                Image.asset(
                  "assets/contacts.jpg",
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) => requiredValidator(value, 'o email'),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding:
                            EdgeInsets.only(), // add padding to adjust icon
                        child: Icon(Icons.person),
                      ),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 13),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    obscureText: !showPassword,
                    controller: _passwordController,
                    validator: (value) => requiredValidator(value, 'a senha'),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding:
                            EdgeInsets.only(), // add padding to adjust icon
                        child: Icon(Icons.lock),
                      ),
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffix: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      _authenticationService
                          .loginUser(email: email, password: password)
                          .then((erro) {
                        if (erro == "Email ou senha invalidos!" ||
                            erro == "Erro de login") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("ERRO"),
                                content: SingleChildScrollView(
                                  child: Text(erro),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Voltar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      });
                    }
                  },
                  child: Container(
                    color: Colors.purple[300],
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/newUser');
                  },
                  child: Container(
                    child: const Text(
                      'Ainda não tem uma conta? Registre-se agora!',
                      style: TextStyle(color: Colors.lightBlue, fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/esqueceuSenha");
                        },
                        child: Text(
                          'Esqueceu a senha?',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
