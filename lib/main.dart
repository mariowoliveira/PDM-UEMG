import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veiculos/controlles/atualizarMontadora.dart';
import 'package:veiculos/controlles/cadastrarMontadora.dart';
import 'package:veiculos/controlles/excluirMontadora.dart';
import 'package:veiculos/telas/tela_base/tela_base.dart';

import 'controlles/listaMontadoras.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(
          create: (_) => ListaMontadoras(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CadastrarMontadora(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AtualizarMontadora(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ExcluirMontadora(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TelaBase(),
      ),
    );
  }
}