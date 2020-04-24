import 'package:json_annotation/json_annotation.dart';
part 'he_weather.g.dart';

@JsonSerializable()
class HeWeather {
  HeWeather(this.weather);

  @JsonKey(name: 'HeWeather6')
  final List<Item> weather; // 天气详情

  factory HeWeather.fromJson(Map<String, dynamic> json) =>
      _$HeWeatherFromJson(json);

  Map<String, dynamic> toJson(HeWeather instance) =>
      _$HeWeatherToJson(instance);
}

@JsonSerializable()
class Item {
  Item({this.hourly, this.lifestyle, this.forecast, this.basic, this.now});

  final Basic basic; // 默认基础信息

  final Now now; // 今日天气

  @JsonKey(name: 'hourly')
  final List<Hourly> hourly; // 实时天气

  @JsonKey(name: 'daily_forecast')
  final List<Forecast> forecast; // 未来天气

  @JsonKey(name: 'lifestyle')
  final List<Life> lifestyle; // 生活建议

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson(Item instance) => _$ItemToJson(instance);
}

@JsonSerializable()
class Basic {
  Basic(this.location, this.latitude, this.longitude);

  final String location;

  @JsonKey(name: 'lat')
  final String latitude;

  @JsonKey(name: 'lon')
  final String longitude;

  // 从Json中建立字段映射关系
  factory Basic.fromJson(Map<String, dynamic> json) => _$BasicFromJson(json);

  // 把类示例的属性转成Json
  Map<String, dynamic> toJson(Basic instance) => _$BasicToJson(instance);
}

@JsonSerializable()
class Now {
  Now(this.condCode, this.condDesc, this.feelTemp, this.temp);

  @JsonKey(name: 'cond_code')
  final String condCode; // 天气代码

  @JsonKey(name: 'cond_txt')
  final String condDesc; // 天气状态描述

  @JsonKey(name: 'fl')
  final String feelTemp; // 体感温度

  @JsonKey(name: 'tmp') // 室外温度
  final String temp;

  factory Now.fromJson(Map<String, dynamic> json) => _$NowFromJson(json);

  Map<String, dynamic> toJson(Now instance) => _$NowToJson(instance);
}

@JsonSerializable()
class Forecast {
  Forecast(this.sunRise, this.sunSet, this.tempMax, this.tempMin); // 最低温

  @JsonKey(name: 'sr')
  final String sunRise; // 日出时间

  @JsonKey(name: 'ss')
  final String sunSet; // 日落时间

  @JsonKey(name: 'tmp_max')
  final String tempMax; // 最高温

  @JsonKey(name: 'tmp_min')
  final String tempMin;

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);

  Map<String, dynamic> toJson(Forecast instance) => _$ForecastToJson(instance);
}

@JsonSerializable()
class Hourly {
  Hourly({this.condCode, this.condDesc, this.temp});

  @JsonKey(name: 'cond_code')
  final String condCode;

  @JsonKey(name: 'cond_txt')
  final String condDesc;

  @JsonKey(name: 'tmp')
  final String temp;

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);

  Map<String, dynamic> toJson(Hourly instance) => _$HourlyToJson(instance);
}

@JsonSerializable()
class Life {
  Life({this.type, this.intro, this.desc});

  final String type; // 建议类型

  @JsonKey(name: 'brf')
  final String intro; // 生活指数简介

  @JsonKey(name: 'txt')
  final String desc; // 生活指数描述

  factory Life.fromJson(Map<String, dynamic> json) => _$LifeFromJson(json);

  Map<String, dynamic> toJson(Life instance) => _$LifeToJson(instance);
}
