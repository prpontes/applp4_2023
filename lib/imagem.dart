class Imagem{
  int? _id;
  String? _url;
  String? _titulo;
  String? _descricao;
  int? _favorito;

  Imagem({int? id, required String? url, required String? titulo, required String? descricao, int? favorito}){
    _id = id;
    _url = url;
    _titulo = titulo;
    _descricao = descricao;
    _favorito = favorito;
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

  set favorito(int favorito){
    _favorito = favorito;
  }

  int get favorito => _favorito!;

  Map<String, dynamic> toMap(){
    return {
      'id' : _id,
      'url' : _url,
      'titulo' : _titulo,
      'descricao' : _descricao,
      'favorito' : _favorito,
    };
  }
}