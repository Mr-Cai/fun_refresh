import 'package:json_annotation/json_annotation.dart';

part 'extension_app.g.dart';

@JsonSerializable()
class ExtResponse {
  ExtResponse({this.typeList});

  @JsonKey(name: 'type_list')
  final List<ItemType> typeList;

  factory ExtResponse.fromJson(Map<String, dynamic> json) =>
      _$ExtResponseFromJson(json);

  Map<String, dynamic> toJson(ExtResponse instance) =>
      _$ExtResponseToJson(instance);
}

@JsonSerializable()
class ItemType {
  ItemType(this.title, this.data);

  final String title;
  final List<Data> data;

  factory ItemType.fromJson(Map<String, dynamic> json) =>
      _$ItemTypeFromJson(json);

  Map<String, dynamic> toJson(ItemType instance) => _$ItemTypeToJson(instance);
}

@JsonSerializable()
class Data {
  Data({this.pic, this.title, this.desc, this.link});

  final String pic;
  final String title;
  final String desc;
  final String link;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson(Data instance) => _$DataToJson(instance);
}
