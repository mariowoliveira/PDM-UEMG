
class Montadora {

  String? id;
  String nome="";

  Montadora({
    this.id,
    required this.nome,
});

  Montadora.create(){
    id = "";
    nome= '';
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    return data;
  }

  Montadora.fromJson(Map<String, dynamic> json, String key) {
    id = key;
    nome = json["nome"];
  }

}