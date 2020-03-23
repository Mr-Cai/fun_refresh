import 'package:json_annotation/json_annotation.dart';
part 'eye_related.g.dart';

@JsonSerializable()
class EyeRelated {
  EyeRelated({this.itemList});

  final List<Item> itemList; // 推荐视频列表

  factory EyeRelated.fromJson(Map<String, dynamic> json) =>
      _$EyeRelatedFromJson(json);

  Map<String, dynamic> toJson(EyeRelated instance) =>
      _$EyeRelatedToJson(instance);
}

@JsonSerializable()
class Item {
  Item({this.data, this.type});

  final Data data; // 集合中的条目对象
  final String type; // 单元分类

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson(Item instance) => _$ItemToJson(instance);
}

@JsonSerializable()
class Data {
  Data({
    this.id,
    this.title,
    this.description,
    this.author,
    this.cover,
    this.playUrl,
    this.duration,
    this.date,
  });

  final int id;
  final String title;
  final String description;
  final Author author;
  final Cover cover;
  final String playUrl;
  final int duration;
  final num date;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson(Data instance) => _$DataToJson(instance);
}

@JsonSerializable()
class Author {
  Author({this.icon, this.name, this.description});
  final String icon;
  final String name;
  final String description;
  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson(Author instance) => _$AuthorToJson(instance);
}

@JsonSerializable()
class Cover {
  Cover({this.detail});
  final String detail;
  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);
  Map<String, dynamic> toJson(Cover instance) => _$CoverToJson(instance);
}
