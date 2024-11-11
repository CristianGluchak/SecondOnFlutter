import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second/services/authentication_service.dart';
import 'package:second/services/firestore_service.dart';
import 'package:second/widgets/snack_bar_widget.dart';

class HomeView extends StatefulWidget {
  final User user;
  const HomeView({super.key, required this.user});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final FirestoreService fireStoreService = FirestoreService();
  String _addname = "Salvar";

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
              widget.user.displayName != null
                  ? widget.user.displayName!
                  : "Não informado",
              style: TextStyle(fontSize: 20),
            ),
            accountEmail: Text(widget.user.email != null
                ? widget.user.email!
                : "Não informado")),
        ListTile(
          title: Text('Sair'),
          leading: Icon(Icons.output_outlined),
          onTap: () {
            AuthenticationService().logoutUser();
          },
        ),
        Divider(
          thickness: 2,
        )
      ])),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getContacts(),
        builder: (context, snapshot) {
          //todo: ta dando pau
          if (snapshot.hasData) {
            List contactsList = snapshot.data!.docs;
            return ListView.builder(
                itemCount: contactsList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = contactsList[index];
                  String docId = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String contactName = data["name"];
                  String contactNumber = data["number"];
                  return Padding(
                      padding: EdgeInsets.all(16),
                      child: ListTile(
                          tileColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          title: Text(contactName),
                          subtitle: Text(contactNumber),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _openModalForm(docId: docId);
                                },
                                icon: Icon(Icons.settings),
                              ),
                              IconButton(
                                onPressed: () {
                                  fireStoreService.deleteContact(docId);
                                  snackBarWidget(
                                      context: context,
                                      title: "Dados deletados com sucesso",
                                      isError: false);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          )));
                });
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openModalForm();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _openModalForm({String? docId}) async {
    if (docId != null) {
      DocumentSnapshot document = await fireStoreService.getContact(docId);
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      _nameController.text = data["name"];
      _numberController.text = data["number"];
      _addname = "Editar";
    }

    showModalBottomSheet(
        backgroundColor: Color.fromARGB(255, 99, 131, 151),
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Adicionar contatos",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Divider(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: "Nome",
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.text_fields_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _numberController,
                  decoration: InputDecoration(
                      labelText: "Numero",
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.text_fields_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (docId == null) {
                        fireStoreService.addContact(
                            _nameController.text, _numberController.text);
                      } else {
                        fireStoreService.updateContact(docId,
                            _nameController.text, _numberController.text);
                      }
                      _nameController.clear();
                      _numberController.clear();
                      _addname == "Salvar"
                          ? snackBarWidget(
                              context: context,
                              title: "Dados inseridos com sucesso",
                              isError: false)
                          : snackBarWidget(
                              context: context,
                              title: "Dados atualizados com sucesso",
                              isError: false);
                      Navigator.pop(context);
                    },
                    child: Text(_addname))
              ],
            ),
          );
        });
  }
}
