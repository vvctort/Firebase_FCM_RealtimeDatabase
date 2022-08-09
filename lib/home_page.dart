import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _mensagemController = TextEditingController();
  FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference ref;

  @override
  void initState() {
    ref = database.ref();
    ref.onValue.listen((event) {
      if (event.snapshot.value == null) {
        return;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuario'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _mensagemController,
          ),
        ),
        const SizedBox(height: 40,),
        FloatingActionButton(child:const Icon(Icons.add),onPressed: () async {
          await ref
              .child('user')
              .push()
              .set({"name": _mensagemController.text});
              
        })
      ]),
    );
  }
}
