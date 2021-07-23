import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:veiculos/helpers/parametros.dart';
import '../../models/models.dart';

class CadastrarVeiculos extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> postCadastrarVeiculos({
    required Montadora montadora,
    required Veiculo veiculo,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {

    loading = true;

    var corpo = json.encode({
      "nome":veiculo.nome,
      "imagem":veiculo.imagem,
      "valor":veiculo.valor,
    });
print(corpo);
    try{

      final response = await dio.post(
        apiVeiculos+montadora.id!+"/veiculos/.json",
        data: corpo,
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);
        if(data.containsKey('name')){
          onSuccess("Veiculo cadastrado com sucesso!");
        }else{
          onFail("Erro ao cadastrar Veiculo!");
        }
      }else{
        onFail("Erro ao cadastrar Veiculo!");
      }

    }catch(e){
      onFail("Erro ao cadastrar Veiculo!");
      print(e);
    }

    loading = false;

  }

}