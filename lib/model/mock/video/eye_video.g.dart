// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eye_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EyeVideo _$EyeVideoFromJson(Map<String, dynamic> json) {
  return EyeVideo(
    (json['itemList'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['nextPageUrl'] as String,
  );
}

Map<String, dynamic> _$EyeVideoToJson(EyeVideo instance) => <String, dynamic>{
      'itemList': instance.itemList,
      'nextPageUrl': instance.nextPageUrl,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    json['type'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'data': instance.data,
      'type': instance.type,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['content'] == null
        ? null
        : Content.fromJson(json['content'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'content': instance.content,
    };

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
    json['data'] == null
        ? null
        : InnerData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'data': instance.data,
    };

InnerData _$InnerDataFromJson(Map<String, dynamic> json) {
  return InnerData(
    json['id'] as int,
    json['title'] as String,
    json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
    json['cover'] == null
        ? null
        : Cover.fromJson(json['cover'] as Map<String, dynamic>),
    json['playUrl'] as String,
    json['description'] as String,
    json['duration'] as int,
  );
}

Map<String, dynamic> _$InnerDataToJson(InnerData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'cover': instance.cover,
      'playUrl': instance.playUrl,
      'duration': instance.duration,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
    json['icon'] as String,
    json['name'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'icon': instance.icon,
      'name': instance.name,
      'description': instance.description,
    };

Cover _$CoverFromJson(Map<String, dynamic> json) {
  return Cover(
    json['detail'] as String,
  );
}

Map<String, dynamic> _$CoverToJson(Cover instance) => <String, dynamic>{
      'detail': instance.detail,
    };
