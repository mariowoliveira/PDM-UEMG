import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veiculos/common/common.dart';
import 'package:veiculos/controlles/cadastrarMontadora.dart';
import 'package:veiculos/controlles/listaMontadoras.dart';
import 'package:veiculos/models/montadora.dart';

class TelaCadastroMontadora extends StatefulWidget {

  @override
  _TelaCadastroMontadoraState createState() => _TelaCadastroMontadoraState();
}

class _TelaCadastroMontadoraState extends State<TelaCadastroMontadora> {
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  final scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();

  void reset(){
    _nomeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CadastrarMontadora,ListaMontadoras>(

      builder: (_,cadastrarMontadora,listaMontadora,__){

        return Scaffold(
          key: scaffoldGlobalKey,
          appBar: AppBar(
            title: Text("Cadastro para Montadora"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()async{
              if(formGlobalKey.currentState!.validate()){

                await cadastrarMontadora.postCadastrarMontadora(
                    montadora: Montadora(nome:_nomeController.text),
                    onSuccess: (text){

                      listaMontadora.getListaMontadoras(); 

                      scaffoldGlobalKey.currentState!.showSnackBar(
                          SnackBar(
                            content: Text(
                              text,
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          )
                      );

                      Future.delayed(Duration(seconds: 2)).then((_){
                        Navigator.pop(context);
                      });

                    },
                    onFail: (text){

                    },
                );

                reset();
              }
            },
            child: Icon(
                Icons.save,
                color: Colors.white
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formGlobalKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      keyboardType: TextInputType.text,
                      validator: (nome) {
                        if (nome!.trim().isEmpty) {
                          return "Preencha o Campo!";
                        } else if (nome.trim().length < 2) {
                          return "Insira uma montadora existente!";
                        }
                        return null;
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
        );

      },

    );
  }
}
