class Medicamento {
  int _id;
  String _nome;
  String _principio;
  String _concentracao;
  String _preco;
  //construtor da classe
  Medicamento(this._nome, this._principio, this._concentracao, this._preco);
  //converte dados de vetor para objeto
  Medicamento.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._principio = obj['principio'];
    this._concentracao = obj['concentracao'];
    this._preco = obj['preco'];
  }
  // encapsulamento
  int get id => _id;
  String get nome => _nome;
  String get principio => _principio;
  String get concentracao => _concentracao;
  String get preco => _preco;
 //converte o objeto em um map
 Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
       map['id'] = _id;
    }
    map['nome'] = _nome;
    map['principio'] = _principio;
    map['concentracao'] = _concentracao;
    map['preco'] = _preco;
    return map;
  }
  //converte map em um objeto
  Medicamento.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._principio = map['principio'];
    this._concentracao = map['concentracao'];
    this._preco = map['preco'];
  }
}
