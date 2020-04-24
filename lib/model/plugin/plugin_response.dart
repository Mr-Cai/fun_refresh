import 'package:json_annotation/json_annotation.dart';

part 'plugin_response.g.dart';

@JsonSerializable()
class PluginResponse {
  PluginResponse({this.pluginList});

  @JsonKey(name: 'plugin_list')
  final List<Item> pluginList;

  factory PluginResponse.fromJson(Map<String, dynamic> json) =>
      _$PluginResponseFromJson(json);

  Map<String, dynamic> toJson(PluginResponse instance) =>
      _$PluginResponseToJson(instance);
}

@JsonSerializable()
class Item {
  Item({this.desc, this.pic});

  final String pic;
  final String desc;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson(Item instance) => _$ItemToJson(instance);
}
