import 'package:flutter/material.dart';
import 'package:second/views/home_view.dart';

void main() {
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
      home: SecondApp(),
      routes: {
        'homePage': (context) => HomeView(),
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
  final _form = GlobalKey<FormState>();

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
      body: Form(
        key: _form,
        child: Column(
          children: [
            SizedBox(height: 150),
            Text(
              'Login',
              style: TextStyle(color: Colors.blue[700], fontSize: 30),
            ),
            SizedBox(height: 13),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'por favor, insira seu email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(), // add padding to adjust icon
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'por favor, insira sua senha';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(), // add padding to adjust icon
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
                if (_form.currentState!.validate()) {
                  Navigator.pushNamed(context, 'homePage');
                }
              },
              child: Container(
                color: Colors.purple[300],
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text(
                  'Entrar',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
