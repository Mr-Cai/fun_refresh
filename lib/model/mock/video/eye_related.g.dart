// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eye_related.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EyeRelated _$EyeRelatedFromJson(Map<String, dynamic> json) {
  return EyeRelated(
    itemList: (json['itemList'] as List)
        ?.map((e) =>
            e == null ? null : RelatedItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EyeRelatedToJson(EyeRelated instance) =>
    <String, dynamic>{
      'itemList': instance.itemList,
    };

RelatedItem _$RelatedItemFromJson(Map<String, dynamic> json) {
  return RelatedItem(
    data: json['data'] == null
        ? null
        : InnerData.fromJson(json['data'] as Map<String, dynamic>),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$RelatedItemToJson(RelatedItem instance) =>
    <String, dynamic>{
      'data': instance.data,
      'type': instance.type,
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
