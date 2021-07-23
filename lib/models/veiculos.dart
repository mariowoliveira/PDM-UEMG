class Veiculo{
  String id = "";
  String nome = "";
  double valor = 0;
  String imagem = "";

  Veiculo({
    required this.id,
    required this.nome,
    required this.valor,
    required this.imagem,

  });
  Veiculo.fromJson(Map<String, dynamic> json, String key) {
    id = key;
    nome   = json["nome"];
    valor  = json["valor"];
    imagem = json["imagem"];
  }
}