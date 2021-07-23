import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veiculos/controlles/editar_veiculo.dart';
import 'package:veiculos/controlles/lista_veiculos.dart';
import '../helpers/helpers.dart';
import '../models/models.dart';

class TelaEditarVeiculos extends StatefulWidget {

  final Veiculo veiculo;
  final Montadora montadora;
  TelaEditarVeiculos({required this.montadora, required this.veiculo});

  @override
  _TelaEditarVeiculosState createState() => _TelaEditarVeiculosState();
}

class _TelaEditarVeiculosState extends State<TelaEditarVeiculos> {

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

    return Consumer2<EditarVeiculos,ListaVeiculos>(

      builder: (_,editarVeiculos,listaVeiculos,__){

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Cadastrar Veículo"),
            centerTitle: true,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: editarVeiculos.loading?null:()async{

              if(formKey.currentState!.validate()){

                await editarVeiculos.patchEditarVeiculos(
                    montadora: Montadora(
                      id: widget.montadora.id,
                      nome: "",
                    ),
                    veiculo: Veiculo(
                      nome:  _nomeController.text.isNotEmpty?_nomeController.text:widget.veiculo.nome,
                      imagem: _imagenController.text.isNotEmpty?_imagenController.text:widget.veiculo.imagem,
                      valor: _valorController.text.isNotEmpty?double.parse(_valorController.text.replaceAll(",", ".")):widget.veiculo.valor,
                      id: widget.veiculo.id,
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
            tooltip: 'Editar Veículo',
            backgroundColor: editarVeiculos.loading?Colors.grey:colorPrimary,
            elevation: editarVeiculos.loading?0:3,
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(editarVeiculos.loading)
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
                          initialValue: widget.veiculo.nome,
                          keyboardType: TextInputType.text,
                          onChanged: (text){
                            _nomeController.text = text;
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
                          initialValue: widget.veiculo.valor.toString(),
                          keyboardType: TextInputType.number,
                          onChanged: (text){
                            _valorController.text = text.replaceAll(",", ".");
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
                          initialValue: widget.veiculo.imagem,
                          keyboardType: TextInputType.text,
                          onChanged: (text){
                            _imagenController.text = text;
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