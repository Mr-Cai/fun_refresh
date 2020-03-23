// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eye_related.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EyeRelated _$EyeRelatedFromJson(Map<String, dynamic> json) {
  return EyeRelated(
    itemList: (json['itemList'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EyeRelatedToJson(EyeRelated instance) =>
    <String, dynamic>{
      'itemList': instance.itemList,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'data': instance.data,
      'type': instance.type,
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
    date: json['date'] as num,
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
      'date': instance.date,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
    icon: json['icon'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'icon': instance.icon,
      'name': instance.name,
      'description': instance.description,
    };

Cover _$CoverFromJson(Map<String, dynamic> json) {
  return Cover(
    detail: json['detail'] as String,
  );
}

Map<String, dynamic> _$CoverToJson(Cover instance) => <String, dynamic>{
      'detail': instance.detail,
    };
