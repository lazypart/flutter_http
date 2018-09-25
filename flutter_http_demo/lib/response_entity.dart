import 'package:flutter_http/entity/base_entity.dart';

/// 返回数据类型
/// 继承于BaseEntity，泛型为返回数据类型
class ResponseEntity extends BaseEntity<ResponseEntity>{
  final String title;
  final String content;

  const ResponseEntity({this.title, this.content});

  ResponseEntity.fromJson(Map<String, dynamic> json):
        title = json['title'], content = json['content'];

  // 重写fromJsonMap方法，将map转换为返回数据类型
  @override
  ResponseEntity fromJsonMap(Map<String, dynamic> json) {
    return ResponseEntity.fromJson(json);
  }

}