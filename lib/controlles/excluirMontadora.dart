import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:veiculos/helpers/parametros.dart';

class ExcluirMontadora extends ChangeNotifier{

  Dio dio = Dio();

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> excluir({
    required String id,
  }) async {

    loading = true;

    try{

      final response = await dio.delete(
        apiMontadorasExcluir+id+".json",
      );

      if(response.statusCode == 200){
        print(response.data);
      }

    }catch(e){

    }

    loading = false;

  }

}