/// 基础实体类
/// 用来将json转换的Map<String, dynamic>转换为相应的实体类。
abstract class BaseEntity<T> {
  const BaseEntity();

  T fromJsonMap(Map<String, dynamic> json);
}