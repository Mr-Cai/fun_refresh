import 'package:fun_refresh/model/mock/video/eye_video.dart';
import 'package:json_annotation/json_annotation.dart';
part 'eye_channel.g.dart';

@JsonSerializable()
class EyeChannel {
  EyeChannel({this.itemList, this.pgcInfo});

  final List<VideoItem> itemList;
  final ChannelInfo pgcInfo;

  factory EyeChannel.fromJson(Map<String, dynamic> json) =>
      _$EyeChannelFromJson(json);

  Map<String, dynamic> toJson(EyeChannel instance) =>
      _$EyeChannelToJson(instance);
}

@JsonSerializable()
class VideoItem {
  VideoItem({this.data});

  final InnerData data;

  factory VideoItem.fromJson(Map<String, dynamic> json) =>
      _$VideoItemFromJson(json);

  Map<String, dynamic> toJson(VideoItem instance) =>
      _$VideoItemToJson(instance);
}


@JsonSerializable()
class Cover {
  Cover({this.detail});

  final String detail;

  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);

  Map<String, dynamic> toJson(Cover instance) => _$CoverToJson(instance);
}

@JsonSerializable()
class Author {
  Author({this.link});

  final String link;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson(Author instance) => _$AuthorToJson(instance);
}

@JsonSerializable()
class ChannelInfo {
  ChannelInfo({
    this.icon,
    this.name,
    this.description,
    this.followCount,
    this.videoCount,
    this.shareCount,
    this.collectCount,
  });

  final String icon;
  final String name;
  final String description;
  final num followCount;
  final num videoCount;
  final num shareCount;
  final num collectCount;

  factory ChannelInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelInfoFromJson(json);

  Map<String, dynamic> toJson(ChannelInfo instance) =>
      _$ChannelInfoToJson(instance);
}
