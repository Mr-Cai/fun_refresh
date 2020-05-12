// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PluginResponse _$PluginResponseFromJson(Map<String, dynamic> json) {
  return PluginResponse(
    pluginList: (json['plugin_list'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PluginResponseToJson(PluginResponse instance) =>
    <String, dynamic>{
      'plugin_list': instance.pluginList,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['route'] as String,
    name: json['name'] as String,
    desc: json['desc'] as String,
    pic: json['pic'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'pic': instance.pic,
      'desc': instance.desc,
      'route': instance.route,
    };
