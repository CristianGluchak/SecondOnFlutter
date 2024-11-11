import 'package:flutter/material.dart';
import 'package:second/controls/text_form_field_wdiget.dart';
import 'package:second/services/authentication_service.dart';
import 'package:second/widgets/snack_bar_widget.dart';

class NewUserView extends StatefulWidget {
  const NewUserView({super.key});

  @override
  State<NewUserView> createState() => _NewUserViewState();
}

class _NewUserViewState extends State<NewUserView> {
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthenticationService authenticationService = AuthenticationService();

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
                child: Column(children: [
                  SizedBox(height: 10),
                  Image.asset("assets/contacts.jpg"),
                  SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) => requiredValidator(value, 'o nome'),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(),
                          child: Icon(Icons.person),
                        ),
                        labelText: 'Nome',
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
                      validator: (value) => requiredValidator(value, 'o email'),
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(),
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
                      validator: (value) => requiredValidator(value, 'a senha'),
                      controller: _passwordController,
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
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      if (_form.currentState?.validate() ?? false) {
                        //Navigator.pushNamed(context, 'homePage');
                        String name = _nameController.text;
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        authenticationService
                            .registerUser(
                                name: name, email: email, password: password)
                            .then((value) {
                          if (value != null) {
                            snackBarWidget(
                                context: context, title: value, isError: true);
                          } else {
                            snackBarWidget(
                                context: context,
                                title: 'Cadastro efetuado com sucesso!',
                                isError: false);
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                    child: Container(
                      color: Colors.purple[300],
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ]))));
  }
}
