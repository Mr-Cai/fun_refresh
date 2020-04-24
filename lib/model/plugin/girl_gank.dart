import 'package:json_annotation/json_annotation.dart';
part 'girl_gank.g.dart';

@JsonSerializable()
class GirlGank {
  GirlGank({this.page, this.pageCount, this.totalCounts, this.data});

  final List<Data> data;
  final int page;

  @JsonKey(name: 'page_count')
  final int pageCount;

  @JsonKey(name: 'total_counts')
  final int totalCounts;

  factory GirlGank.fromJson(Map<String, dynamic> json) =>
      _$GirlGankFromJson(json);
  Map<String, dynamic> toJson(GirlGank instance) => _$GirlGankToJson(instance);
}

@JsonSerializable()
class Data {
  Data({this.publishedAt, this.url, this.desc});

  final String url;
  final String desc;
  final String publishedAt;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson(Data instance) => _$DataToJson(instance);
}
