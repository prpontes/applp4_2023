class Imagem{
  int? _id;
  String? _url;
  String? _titulo;
  String? _descricao;

  Imagem({int? id, required String? url, required String? titulo, required String? descricao}){
    _id = id;
    _url = url;
    _titulo = titulo;
    _descricao = descricao;
  }

  int get id => _id!;

  set url(String url){
    _url = url;
  }

  String get url => _url!;

  set titulo(String titulo){
    _titulo = titulo;
  }

  String get titulo => _titulo!;

  set descricao(String descricao){
    _descricao = descricao;
  }

  String get descricao => _descricao!;

  Map<String, dynamic> toMap(){
    return {
      'id' : _id,
      'url' : _url,
      'titulo' : _titulo,
      'descricao' : _descricao
    };
  }
}