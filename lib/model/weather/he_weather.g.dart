// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'he_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeWeather _$HeWeatherFromJson(Map<String, dynamic> json) {
  return HeWeather(
    (json['HeWeather6'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HeWeatherToJson(HeWeather instance) => <String, dynamic>{
      'HeWeather6': instance.weather,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    hourly: (json['hourly'] as List)
        ?.map((e) =>
            e == null ? null : Hourly.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    lifestyle: (json['lifestyle'] as List)
        ?.map(
            (e) => e == null ? null : Life.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    forecast: (json['daily_forecast'] as List)
        ?.map((e) =>
            e == null ? null : Forecast.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    basic: json['basic'] == null
        ? null
        : Basic.fromJson(json['basic'] as Map<String, dynamic>),
    now: json['now'] == null
        ? null
        : Now.fromJson(json['now'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'basic': instance.basic,
      'now': instance.now,
      'hourly': instance.hourly,
      'daily_forecast': instance.forecast,
      'lifestyle': instance.lifestyle,
    };

Basic _$BasicFromJson(Map<String, dynamic> json) {
  return Basic(
    json['location'] as String,
    json['lat'] as String,
    json['lon'] as String,
  );
}

Map<String, dynamic> _$BasicToJson(Basic instance) => <String, dynamic>{
      'location': instance.location,
      'lat': instance.latitude,
      'lon': instance.longitude,
    };

Now _$NowFromJson(Map<String, dynamic> json) {
  return Now(
    json['cond_code'] as String,
    json['cond_txt'] as String,
    json['fl'] as String,
    json['tmp'] as String,
  );
}

Map<String, dynamic> _$NowToJson(Now instance) => <String, dynamic>{
      'cond_code': instance.condCode,
      'cond_txt': instance.condDesc,
      'fl': instance.feelTemp,
      'tmp': instance.temp,
    };

Forecast _$ForecastFromJson(Map<String, dynamic> json) {
  return Forecast(
    json['sr'] as String,
    json['ss'] as String,
    json['tmp_max'] as String,
    json['tmp_min'] as String,
  );
}

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'sr': instance.sunRise,
      'ss': instance.sunSet,
      'tmp_max': instance.tempMax,
      'tmp_min': instance.tempMin,
    };

Hourly _$HourlyFromJson(Map<String, dynamic> json) {
  return Hourly(
    condCode: json['cond_code'] as String,
    condDesc: json['cond_txt'] as String,
    temp: json['tmp'] as String,
  );
}

Map<String, dynamic> _$HourlyToJson(Hourly instance) => <String, dynamic>{
      'cond_code': instance.condCode,
      'cond_txt': instance.condDesc,
      'tmp': instance.temp,
    };

Life _$LifeFromJson(Map<String, dynamic> json) {
  return Life(
    type: json['type'] as String,
    intro: json['brf'] as String,
    desc: json['txt'] as String,
  );
}

Map<String, dynamic> _$LifeToJson(Life instance) => <String, dynamic>{
      'type': instance.type,
      'brf': instance.intro,
      'txt': instance.desc,
    };
