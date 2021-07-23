import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:veiculos/helpers/parametros.dart';
import '../../../models/models.dart';

class ListaVeiculos extends ChangeNotifier{

  Dio dio = Dio();

  List<Veiculo> listaVeiculos = [];

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> getListaVeiculos({required String idMontadora}) async {

    loading = true;
    listaVeiculos.clear();

    try{

      final response = await dio.get(
        apiVeiculos+idMontadora+"/veiculos/.json",
      );

      if(response.statusCode == 200){

        Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

        data.forEach((key, value) {
          Veiculo veiculo = Veiculo.fromJson(value,key);
          listaVeiculos.add(veiculo);
        });

      }else{
        listaVeiculos.clear();
      }

    }catch(e){
      listaVeiculos.clear();
    }

    loading = false;

  }

}