import 'package:json_annotation/json_annotation.dart';
part 'eye_video.g.dart';

@JsonSerializable()
class EyeVideo {
  EyeVideo({this.itemList, this.nextPageUrl});

  final List<VideoTile> itemList; // 视频列表
  final String nextPageUrl; // 每页末尾的查询下一页链接

  factory EyeVideo.fromJson(Map<String, dynamic> json) =>
      _$EyeVideoFromJson(json);

  Map<String, dynamic> toJson(EyeVideo instance) => _$EyeVideoToJson(instance);
}

@JsonSerializable()
class VideoTile {
  VideoTile({this.data, this.type});

  final Data data; // 集合中的条目对象
  final String type; // 组别分类(分隔线、图片、链接)

  factory VideoTile.fromJson(Map<String, dynamic> json) =>
      _$VideoTileFromJson(json);

  Map<String, dynamic> toJson(VideoTile instance) =>
      _$VideoTileToJson(instance);
}

@JsonSerializable()
class Data {
  Data({this.content});

  final Content content;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson(Data instance) => _$DataToJson(instance);
}

@JsonSerializable()
class Content {
  Content({this.data});

  final InnerData data;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson(Content instance) => _$ContentToJson(instance);
}

@JsonSerializable()
class InnerData {
  InnerData(
    this.releaseTime, {
    this.id,
    this.title,
    this.author,
    this.cover,
    this.playUrl,
    this.description,
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
  final num releaseTime;

  factory InnerData.fromJson(Map<String, dynamic> json) =>
      _$InnerDataFromJson(json);

  Map<String, dynamic> toJson(InnerData instance) =>
      _$InnerDataToJson(instance);
}

@JsonSerializable()
class Author {
  Author(
    this.link, {
    this.id,
    this.icon,
    this.name,
    this.description,
  });

  final int id;
  final String icon;
  final String name;
  final String link;
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
