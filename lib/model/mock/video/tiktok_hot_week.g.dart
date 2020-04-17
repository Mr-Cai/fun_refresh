// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tiktok_hot_week.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TiktokHotWeek _$TiktokHotWeekFromJson(Map<String, dynamic> json) {
  return TiktokHotWeek(
    itemList: (json['item_list'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TiktokHotWeekToJson(TiktokHotWeek instance) =>
    <String, dynamic>{
      'item_list': instance.itemList,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    video: json['video'] == null
        ? null
        : Video.fromJson(json['video'] as Map<String, dynamic>),
    desc: json['desc'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'video': instance.video,
      'desc': instance.desc,
    };

Video _$VideoFromJson(Map<String, dynamic> json) {
  return Video(
    playAddr: json['play_addr'] == null
        ? null
        : Cover.fromJson(json['play_addr'] as Map<String, dynamic>),
    dynamicCover: json['dynamic_cover'] == null
        ? null
        : Cover.fromJson(json['dynamic_cover'] as Map<String, dynamic>),
    originCover: json['origin_cover'] == null
        ? null
        : Cover.fromJson(json['origin_cover'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'play_addr': instance.playAddr,
      'dynamic_cover': instance.dynamicCover,
      'origin_cover': instance.originCover,
    };

Cover _$CoverFromJson(Map<String, dynamic> json) {
  return Cover(
    urlList: (json['url_list'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CoverToJson(Cover instance) => <String, dynamic>{
      'url_list': instance.urlList,
    };
