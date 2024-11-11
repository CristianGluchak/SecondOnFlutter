import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:second/controls/text_form_field_wdiget.dart';
import 'package:second/firebase_options.dart';
import 'package:second/services/authentication_service.dart';
import 'package:second/views/forgot_password_view.dart';
import 'package:second/views/home_view.dart';
import 'package:second/views/login_view.dart';
import 'package:second/views/new_user_view.dart';
import 'package:second/widgets/snack_bar_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SecondApp(),
      routes: {
        '/newUser': (context) => NewUserView(),
        '/esqueceuSenha': (context) => const ForgotPasswordView(),
      },
    );
  }
}

class SecondApp extends StatefulWidget {
  const SecondApp({super.key});

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) =>
            snapshot.hasData ? HomeView(user: snapshot.data!) : LoginView());
  }
}
