// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eye_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EyeChannel _$EyeChannelFromJson(Map<String, dynamic> json) {
  return EyeChannel(
    itemList: (json['itemList'] as List)
        ?.map((e) =>
            e == null ? null : VideoItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pgcInfo: json['pgcInfo'] == null
        ? null
        : ChannelInfo.fromJson(json['pgcInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EyeChannelToJson(EyeChannel instance) =>
    <String, dynamic>{
      'itemList': instance.itemList,
      'pgcInfo': instance.pgcInfo,
    };

VideoItem _$VideoItemFromJson(Map<String, dynamic> json) {
  return VideoItem(
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VideoItemToJson(VideoItem instance) => <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    author: json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
    cover: json['cover'] == null
        ? null
        : Cover.fromJson(json['cover'] as Map<String, dynamic>),
    playUrl: json['playUrl'] as String,
    duration: json['duration'] as int,
    releaseTime: json['releaseTime'] as num,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'cover': instance.cover,
      'playUrl': instance.playUrl,
      'duration': instance.duration,
      'releaseTime': instance.releaseTime,
    };

Cover _$CoverFromJson(Map<String, dynamic> json) {
  return Cover(
    detail: json['detail'] as String,
  );
}

Map<String, dynamic> _$CoverToJson(Cover instance) => <String, dynamic>{
      'detail': instance.detail,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
    link: json['link'] as String,
  );
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'link': instance.link,
    };

ChannelInfo _$ChannelInfoFromJson(Map<String, dynamic> json) {
  return ChannelInfo(
    icon: json['icon'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    followCount: json['followCount'] as num,
    videoCount: json['videoCount'] as num,
    shareCount: json['shareCount'] as num,
    collectCount: json['collectCount'] as num,
  );
}

Map<String, dynamic> _$ChannelInfoToJson(ChannelInfo instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'name': instance.name,
      'description': instance.description,
      'followCount': instance.followCount,
      'videoCount': instance.videoCount,
      'shareCount': instance.shareCount,
      'collectCount': instance.collectCount,
    };
