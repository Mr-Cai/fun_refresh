import 'package:json_annotation/json_annotation.dart';
part 'eye_video.g.dart';

@JsonSerializable()
class EyeVideo {
  EyeVideo(this.itemList, this.nextPageUrl);

  final List<Item> itemList; // 视频列表
  final String nextPageUrl; // 每页末尾的查询下一页链接

  factory EyeVideo.fromJson(Map<String, dynamic> json) =>
      _$EyeVideoFromJson(json);

  Map<String, dynamic> toJson(EyeVideo instance) =>
      _$EyeVideoToJson(instance);
}

@JsonSerializable()
class Item {
  Item(this.data, this.type);

  final Data data; // 集合中的条目对象
  final String type; // 组别分类(分隔线、图片、链接)

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
 
  Map<String, dynamic> toJson(Item instance) => _$ItemToJson(instance);
}

@JsonSerializable()
class Data {
  Data(this.content);
  final Content content;
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson(Data instance) => _$DataToJson(instance);
}

@JsonSerializable()
class Content {
  Content(this.data);
  final InnerData data;
  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
  Map<String, dynamic> toJson(Content instance) => _$ContentToJson(instance);
}

@JsonSerializable()
class InnerData {
  InnerData(this.title, this.author, this.cover, this.playUrl);
  final String title;
  final Author author;
  final Cover cover;
  final String playUrl;
  factory InnerData.fromJson(Map<String, dynamic> json) =>
      _$InnerDataFromJson(json);
  Map<String, dynamic> toJson(InnerData instance) =>
      _$InnerDataToJson(instance);
}

@JsonSerializable()
class Author {
  Author(this.icon, this.name);
  final String icon;
  final String name;
  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson(Author instance) => _$AuthorToJson(instance);
}

@JsonSerializable()
class Cover {
  Cover(this.detail);
  final String detail;
  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);
  Map<String, dynamic> toJson(Cover instance) => _$CoverToJson(instance);
}
