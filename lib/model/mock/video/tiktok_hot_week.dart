import 'package:json_annotation/json_annotation.dart';

part 'tiktok_hot_week.g.dart';

@JsonSerializable()
class TiktokHotWeek {
  TiktokHotWeek({this.itemList});

  @JsonKey(name: 'item_list')
  final List<Item> itemList;

  factory TiktokHotWeek.fromJson(Map<String, dynamic> json) =>
      _$TiktokHotWeekFromJson(json);

  Map<String, dynamic> toJson(TiktokHotWeek instance) =>
      _$TiktokHotWeekToJson(instance);
}

@JsonSerializable()
class Item {
  Item({this.video, this.desc});

  final Video video;
  final String desc;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson(Item instance) => _$ItemToJson(instance);
}

@JsonSerializable()
class Video {
  Video({
    this.playAddr,
    this.dynamicCover,
    this.originCover,
  });

  @JsonKey(name: 'play_addr')
  final Cover playAddr;

  @JsonKey(name: 'dynamic_cover')
  final Cover dynamicCover;

  @JsonKey(name: 'origin_cover')
  final Cover originCover;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson(Video instance) => _$VideoToJson(instance);
}

@JsonSerializable()
class Cover {
  Cover({this.urlList});

  @JsonKey(name: 'url_list')
  final List<String> urlList;

  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);
  Map<String, dynamic> toJson(Cover instance) => _$CoverToJson(instance);
}
