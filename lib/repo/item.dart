import 'package:json_annotation/json_annotation.dart';


part 'item.g.dart';

@JsonSerializable()
class Item {
  Item({required this.type, required this.clipboard, required this.attachment});
  final int type;
  final String clipboard;
  final String attachment;



  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

}