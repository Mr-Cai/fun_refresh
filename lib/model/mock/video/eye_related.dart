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

// @JsonSerializable()
// class Data extends InnerData {
//   Data({
//     this.id,
//     this.title,
//     this.description,
//     this.authorCard,
//     this.coverCard,
//     this.playUrl,
//     this.duration,
//     this.date,
//   });

//   final int id;
//   final String title;
//   final String description;

//   @JsonKey(name: 'author')
//   final Author authorCard;

//   @JsonKey(name: 'cover')
//   final Cover coverCard;

//   final String playUrl;
//   final int duration;
//   final num date;

//   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

//   @override
//   Map<String, dynamic> toJson(InnerData instance) => _$DataToJson(instance);
// }

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
