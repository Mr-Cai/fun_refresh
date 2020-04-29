// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confetti_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfettiResponse _$ConfettiResponseFromJson(Map<String, dynamic> json) {
  return ConfettiResponse(
    typeList: (json['type_list'] as List)
        ?.map((e) =>
            e == null ? null : ItemType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ConfettiResponseToJson(ConfettiResponse instance) =>
    <String, dynamic>{
      'type_list': instance.typeList,
    };

ItemType _$ItemTypeFromJson(Map<String, dynamic> json) {
  return ItemType(
    json['title'] as String,
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ItemTypeToJson(ItemType instance) => <String, dynamic>{
      'title': instance.title,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    pic: json['pic'] as String,
    title: json['title'] as String,
    desc: json['desc'] as String,
    link: json['link'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'pic': instance.pic,
      'title': instance.title,
      'desc': instance.desc,
      'link': instance.link,
    };
