import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veiculos/common/custom_drawer.dart';
import 'package:veiculos/controlles/atualizarMontadora.dart';
import 'package:veiculos/controlles/excluirMontadora.dart';
import 'package:veiculos/controlles/listaMontadoras.dart';
import 'package:veiculos/models/montadora.dart';
import 'package:veiculos/telas/tela_atualizar_montadora.dart';
import 'package:veiculos/telas/tela_cadastro_montadora.dart';
import 'package:veiculos/telas/tela_veiculos.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  List<Montadora> listamontadoras = [];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ListaMontadoras, ExcluirMontadora>(
      builder: (_, listaMontadoras, excluirMontadora, __) {
        return Scaffold(
          backgroundColor: Color(0xFFEEEEEE),
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: Text("Montadoras"),
            elevation: 0,
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TelaCadastroMontadora(),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
          body: listaMontadoras.loading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.red,
                ))
              : Container(
                  padding: EdgeInsets.all(24),
                  child: ListView.builder(
                    itemCount: listaMontadoras.listaMontadoras.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: excluirMontadora.loading
                            ? null
                            : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TelaVeiculos(
                                      montadora: listaMontadoras
                                          .listaMontadoras[index],
                                    ),
                                  ),
                                );
                              },
                        child: Card(
                          elevation: 3,
                          color: excluirMontadora.loading
                              ? Colors.grey
                              : Colors.white,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  child: Center(
                                    child: Text(
                                      listaMontadoras
                                          .listaMontadoras[index].nome,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: excluirMontadora.loading
                                          ? null
                                          : () async {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TelaAtualizarMontadora(
                                                    montadora: listaMontadoras
                                                        .listaMontadoras[index],
                                                  ),
                                                ),
                                              );
                                            },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: excluirMontadora.loading
                                          ? null
                                          : () async {
                                              await excluirMontadora.excluir(
                                                id: listaMontadoras
                                                    .listaMontadoras[index].id
                                                    .toString(),
                                              );
                                              listaMontadoras
                                                  .getListaMontadoras();
                                            },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
