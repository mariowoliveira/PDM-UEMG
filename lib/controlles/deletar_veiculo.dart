import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:veiculos/helpers/parametros.dart';
import '../../models/models.dart';

class DeletarVeiculos extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> deleteDeletarVeiculos({
    required Montadora montadora,
    required Veiculo veiculo,
  }) async {

    loading = true;

    try{

      final response = await dio.delete(
        apiVeiculos+montadora.id!+"/veiculos/"+veiculo.id+".json",
      );

    }catch(e){

    }

    loading = false;

  }

}