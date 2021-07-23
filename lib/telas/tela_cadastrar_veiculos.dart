import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veiculos/controlles/cadastrar_veiculos.dart';
import 'package:veiculos/controlles/lista_veiculos.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

class TelaCadastrarVeiculo extends StatefulWidget {

  final Montadora montadora;
  TelaCadastrarVeiculo({required this.montadora});

  @override
  _TelaCadastrarVeiculoState createState() => _TelaCadastrarVeiculoState();
}

class _TelaCadastrarVeiculoState extends State<TelaCadastrarVeiculo> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _nomeController = TextEditingController();
  final _imagenController = TextEditingController();
  final _valorController = TextEditingController();

  void limparCampos(){
    _nomeController.clear();
    _imagenController.clear();
    _valorController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer2<CadastrarVeiculos,ListaVeiculos>(

      builder: (_,cadastrarVeiculos,listaVeiculos,__){

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Cadastrar Veículo"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: cadastrarVeiculos.loading?null:()async{

              if(formKey.currentState!.validate()){

                await cadastrarVeiculos.postCadastrarVeiculos(
                    montadora: Montadora(
                      id: widget.montadora.id,
                      nome: "",
                    ),
                    veiculo: Veiculo(
                      nome:  _nomeController.text,
                      imagem: _imagenController.text,
                      valor: double.parse(_valorController.text.replaceAll(",", ".")),
                      id: "",
                    ),
                    onSuccess: (text)async{

                      listaVeiculos.getListaVeiculos(idMontadora: widget.montadora.id!);

                      scaffoldKey.currentState!.showSnackBar(
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
                    onFail: (text){}
                );

              }

            },
            tooltip: 'Cadastrar Veículo',
            backgroundColor: cadastrarVeiculos.loading?Colors.grey:colorPrimary,
            elevation: cadastrarVeiculos.loading?0:3,
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(cadastrarVeiculos.loading)
                    LinearProgressIndicator(
                      color: Colors.blueAccent,
                      backgroundColor: Colors.white,
                      minHeight: 5,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 36,),
                        TextFormField(
                          controller: _nomeController,
                          keyboardType: TextInputType.text,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Nome do veículo",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _valorController,
                          keyboardType: TextInputType.number,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Valor do veículo",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24,),
                        TextFormField(
                          controller: _imagenController,
                          keyboardType: TextInputType.text,
                          validator: (text){
                            if(text!.trim().isEmpty)
                              return 'Campo obrigatório';
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Foto do veículo",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        );

      },

    );

  }

}