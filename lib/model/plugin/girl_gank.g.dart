// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'girl_gank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GirlGank _$GirlGankFromJson(Map<String, dynamic> json) {
  return GirlGank(
    page: json['page'] as int,
    pageCount: json['page_count'] as int,
    totalCounts: json['total_counts'] as int,
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GirlGankToJson(GirlGank instance) => <String, dynamic>{
      'data': instance.data,
      'page': instance.page,
      'page_count': instance.pageCount,
      'total_counts': instance.totalCounts,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    publishedAt: json['publishedAt'] as String,
    url: json['url'] as String,
    desc: json['desc'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'url': instance.url,
      'desc': instance.desc,
      'publishedAt': instance.publishedAt,
    };
