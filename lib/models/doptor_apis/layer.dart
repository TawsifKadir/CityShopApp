class Layer {
  int? id;
  String? layerNameEng;
  String? layerNameBng;
  int? layerLevel;

  Layer({this.id, this.layerNameEng, this.layerNameBng, this.layerLevel});

  Layer.fromJson(json) {
    id = json['id'];
    layerNameEng = json['layer_name_eng'];
    layerNameBng = json['layer_name_bng'];
    layerLevel = json['layer_level'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['layer_name_eng'] = layerNameEng;
    map['layer_name_bng'] = layerNameBng;
    map['layer_level'] = layerLevel;
    return map;
  }
}
