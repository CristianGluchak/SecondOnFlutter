import 'package:flutter/material.dart';
import 'package:second/controls/text_form_field_wdiget.dart';
import 'package:second/services/authentication_service.dart';
import 'package:second/widgets/snack_bar_widget.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final AuthenticationService _authenticationService =
        AuthenticationService();
    return Scaffold(
        appBar: AppBar(),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            textAlign: TextAlign.center,
            "Digite seu email e enviaremos um link para que possa resetar sua senha",
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 25),
            child: TextFormField(
                controller: _emailController,
                decoration: decoration("Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => requiredValidator(value, "o email")),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              _authenticationService
                  .passwordReset(_emailController.text)
                  .then((error) {
                error != null
                    ? snackBarWidget(
                        context: context, title: error, isError: true)
                    : snackBarWidget(
                        context: context,
                        title: 'Link enviado com sucesso!',
                        isError: false);
              });
            },
            child: Text('Resetar senha'),
            color: Colors.deepPurple,
            textColor: Colors.white,
          )
        ]));
  }
}
