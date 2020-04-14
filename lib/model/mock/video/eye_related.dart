import 'package:fun_refresh/model/mock/video/eye_video.dart';
import 'package:json_annotation/json_annotation.dart';
part 'eye_related.g.dart';

@JsonSerializable()
class EyeRelated {
  EyeRelated({this.itemList});

  final List<RelatedItem> itemList; // 推荐视频列表

  factory EyeRelated.fromJson(Map<String, dynamic> json) =>
      _$EyeRelatedFromJson(json);

  Map<String, dynamic> toJson(EyeRelated instance) =>
      _$EyeRelatedToJson(instance);
}

@JsonSerializable()
class RelatedItem {
  RelatedItem({this.data, this.type});

  final InnerData data; // 集合中的条目对象
  final String type; // 单元分类

  factory RelatedItem.fromJson(Map<String, dynamic> json) =>
      _$RelatedItemFromJson(json);

  Map<String, dynamic> toJson(RelatedItem instance) =>
      _$RelatedItemToJson(instance);
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
