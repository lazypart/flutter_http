import 'dart:async';

import 'package:flutter_http/entity/base_entity.dart';

/// HttpClient的接口
abstract class IHttpClient{

  /// get请求
  /// @param entity 返回实体类的基类，可以调用entity的fromJsonMap方法转换为相应的实体类
  /// @param path 请求的地址
  /// @param data 请求的数据
  Future<T> get<T extends BaseEntity<T>>(BaseEntity entity, String path, {data});

  /// post请求
  /// @param entity 返回实体类的基类，可以调用entity的fromJsonMap方法转换为相应的实体类
  /// @param path 请求的地址
  /// @param data 请求的数据
  Future<T> post<T extends BaseEntity>(BaseEntity entity, String path, {data});

  /// put请求
  /// @param entity 返回实体类的基类，可以调用entity的fromJsonMap方法转换为相应的实体类
  /// @param path 请求的地址
  /// @param data 请求的数据
  Future<T> put<T extends BaseEntity>(BaseEntity entity, String path, {data});

  /// delete请求
  /// @param entity 返回实体类的基类，可以调用entity的fromJsonMap方法转换为相应的实体类
  /// @param path 请求的地址
  /// @param data 请求的数据
  Future<T> delete<T extends BaseEntity>(BaseEntity entity, String path, {data});

  /// 添加Header
  /// @param headers 头信息
  void addHeader(String key, header);

  /// 获取Header
  /// @return Map<String, dynamic> 返回头信息
  Map<String, dynamic> getHeader();

  /// 设置链接超时
  /// @param connectTimeout 超时时长
  void setConnectTimeout(int connectTimeout);

  /// 设置接受超时
  /// @param receiveTimeout 超时时长
  void setReceiveTimeout(int receiveTimeout);

  /// 设置BaseUrl
  /// @param baseUrl baseUrl
  void setBaseUrl(String baseUrl);
}