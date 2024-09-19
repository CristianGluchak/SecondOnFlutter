import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tela Inicial',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[300],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
          child: Column(children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            'teste',
            style: TextStyle(fontSize: 20),
          ),
          accountEmail: Text('Teste@gmail.com'),
        ),
        ListTile(
          title: Text('Sair'),
          onTap: () {},
          leading: Icon(Icons.output_outlined),
        ),
        Divider(
          thickness: 2,
        )
      ])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo a tela inicial!',
              style: TextStyle(color: Colors.purple[800], fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
