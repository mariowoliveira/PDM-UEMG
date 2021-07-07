import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veiculos/common/common.dart';
import 'package:veiculos/controlles/atualizarMontadora.dart';
import 'package:veiculos/controlles/listaMontadoras.dart';
import 'package:veiculos/models/montadora.dart';

class TelaAtualizarMontadora extends StatefulWidget {
  TelaAtualizarMontadora({required this.montadora});

  final Montadora montadora;

  @override
  _TelaAtualizarMontadoraState createState() => _TelaAtualizarMontadoraState();
}

class _TelaAtualizarMontadoraState extends State<TelaAtualizarMontadora> {
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  String nome = "";

  @override
  Widget build(BuildContext context) {
    return Consumer2<AtualizarMontadora, ListaMontadoras>(
      builder: (_, atualizarMontadora, listaMontadora, __) {
        return Scaffold(
          key: scaffoldGlobalKey,
          appBar: AppBar(
            title: Text("Atualizar Montadora"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formGlobalKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.montadora.nome,
                      keyboardType: TextInputType.text,
                      validator: (nome) {
                        if (nome!.trim().isEmpty) {
                          return "Preencha o Campo!";
                        } else if (nome.trim().length < 2) {
                          return "Insira uma montadora existente!";
                        }
                        return null;
                      },
                      onChanged: (text) {
                        nome = text;
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        labelText: "Nome da montadora",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (formGlobalKey.currentState!.validate()) {
                await atualizarMontadora.atualizarMontadora(
                  montadora: Montadora(
                    id: widget.montadora.id,
                    nome: nome.isNotEmpty ? nome : widget.montadora.nome,
                  ),
                  onSuccess: (text) {

                    print(text);

                    listaMontadora.getListaMontadoras();

                    scaffoldGlobalKey.currentState!.showSnackBar(SnackBar(
                      content: Text(
                        text,
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ));

                    Future.delayed(Duration(seconds: 2)).then((_) {
                      Navigator.pop(context);
                    });
                  },
                  onFail: (_) {},
                );
              }
            },
            child: Icon(Icons.edit_attributes_outlined, color: Colors.white),
          ),
        );
      },
    );
  }
}
