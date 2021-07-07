import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:veiculos/helpers/parametros.dart';
import 'package:veiculos/models/montadora.dart';

class CadastrarMontadora extends ChangeNotifier{

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> postCadastrarMontadora({
    required Montadora montadora,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {

    loading = true;

    var corpo = json.encode({
      "nome":montadora.nome,
    });

    try{

      final response = await Dio().post(
        apiMontadoras,
        data: corpo,
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);
        if(data.containsKey('name')){
          onSuccess("Cadastrado com sucesso!");
        }else{
          onFail("Erro ao cadastrar!");
        }
      }else{
        onFail("Erro ao cadastrar!");
      }

    }catch(e){
      onFail("Erro ao cadastrar!");
    }

    loading = false;

  }

}