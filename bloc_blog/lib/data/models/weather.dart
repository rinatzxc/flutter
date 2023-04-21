import 'package:json_annotation/json_annotation.dart';
part 'weather.g.dart';

@JsonSerializable()
class Weather {
  Map<String, dynamic> coord;
  List<Map<String, dynamic>> weather;
  String base;
  Map<String, dynamic> main;
  int visibility;
  Map<String, dynamic> wind;
  Map<String, dynamic> clouds;
  int dt;
  Map<String, dynamic> sys;
  int timezone;
  int id;
  String name;
  int cod;

  Weather({
    required this.coord,
    required this.weather, 
    required this.base,
    required this.main, // общие сведения о погоде
    required this.visibility,
    required this.wind,//ветер
    required this.clouds, // облачность
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,// город
    required this.cod,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
