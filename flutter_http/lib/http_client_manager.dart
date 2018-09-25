library flutter_http;

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_http/entity/base_entity.dart';
import 'package:flutter_http/http_client.dart';
import 'package:flutter_http/net_error.dart';

/// HttpClient的单例管理类。
class HttpClientManager implements IHttpClient{
  static final HttpClientManager _singleton = new HttpClientManager._internal();
  IHttpClient _httpClient;

  HttpClientManager._internal(){
    // 初始化具体的HttpClient。
    // 我们将网络封装了一层，而没有直接使用具体的网络库。
    // 如果底层网络库变更，只需要扩展一个实现IHttpClient接口新的HttpClient类。而不需要
    // 改动调用层代码。
    _httpClient = new _DioHttpClient();
  }

  //单例
  factory HttpClientManager() {
    return _singleton;
  }

  @override
  void setBaseUrl(String baseUrl) {
    _httpClient.setBaseUrl(baseUrl);
  }

  @override
  void setConnectTimeout(int connectTimeout) {
    _httpClient.setConnectTimeout(connectTimeout);
  }

  @override
  void setReceiveTimeout(int receiveTimeout) {
    _httpClient.setReceiveTimeout(receiveTimeout);
  }

  @override
  Future<T> delete<T extends BaseEntity>(BaseEntity entity, String path, {data})=> _httpClient.delete(entity, path, data: data);

  @override
  Future<T> get<T extends BaseEntity<T>>(BaseEntity entity, String path, {data}){
    return _httpClient.get(entity, path, data: data);
  }

  @override
  Map<String, dynamic> getHeader() {
    return _httpClient.getHeader();
  }

  @override
  Future<T>  post<T extends BaseEntity>(BaseEntity entity, String path, {data}){
    return _httpClient.post(entity, path, data: data);
  }

  @override
  put<T extends BaseEntity>(BaseEntity entity, String path, {data}){
    _httpClient.put(entity, path, data: data);
  }

  @override
  void addHeader(String key, header) {
    _httpClient.addHeader(key, header);
  }
}


///使用Dio网络库的HttpClient。
///实现了IHttpClient接口。
class _DioHttpClient implements IHttpClient {
  Dio _dio;
  final int defaultConnectTimeout = 5000; //默认连接超时为5s
  final int defaultReceiveTimeout = 3000; //默认接收数据超时为3s

  _DioHttpClient(){
    _dio = new Dio();
    // 配置dio实例
    _dio.options.connectTimeout = defaultConnectTimeout;
    _dio.options.receiveTimeout = defaultReceiveTimeout;
    // 在这里还可以添加拦截器，因为拦截器基本不会与调用层产生关联，所以就不做封装了。
  }

  @override
  Future<T> delete<T extends BaseEntity>(BaseEntity entity, String path, {data}) async{
    try{
      // dio执行delete操作
      Response response = await _dio.delete(path, data: data);
      if(response.statusCode == HttpStatus.OK) {
        // 利用BaseEntity将response.data转换为对应的实体类
        T resultEntity = entity.fromJsonMap(response.data);
        assert(resultEntity is T);
        return resultEntity;
      }else {
        // 返回码不是200则抛出异常
        throw NetError(response.statusCode, response.data.toString());
      }
    }catch (exception) {
      //整个过程捕获到异常也会抛出异常
      throw NetError(NetError.unKnowErrorCode, exception.toString());
    }
  }

  @override
  Future<T> get<T extends BaseEntity<T>>(BaseEntity entity, String path, {data}) async{
    try{
      // dio执行get操作
      Response response = await _dio.get(path, data: data);
      if(response.statusCode == HttpStatus.OK) {
        // 利用BaseEntity将response.data转换为对应的实体类
        T resultEntity = entity.fromJsonMap(response.data);
        assert(resultEntity is T);
        return resultEntity;
      }else {
        // 返回码不是200则抛出异常
        throw NetError(response.statusCode, response.data.toString());
      }
    }catch (exception) {
      //整个过程捕获到异常也会抛出异常
      throw NetError(NetError.unKnowErrorCode, exception.toString());
    }
  }

  @override
  Future<T> post<T extends BaseEntity>(BaseEntity entity, String path, {data}) async{
    try{
      Response response = await _dio.post(path, data: data);
      if(response.statusCode == HttpStatus.OK) {
        // 利用BaseEntity将response.data转换为对应的实体类
        T resultEntity = entity.fromJsonMap(response.data);
        assert(resultEntity is T);
        return resultEntity;
      }else {
        // 返回码不是200则抛出异常
        throw NetError(response.statusCode, response.data.toString());
      }
    }catch (exception) {
      //整个过程捕获到异常也会抛出异常
      throw NetError(NetError.unKnowErrorCode, exception.toString());
    }
  }

  @override
  Future<T> put<T extends BaseEntity>(BaseEntity entity, String path, {data}) async{
    try{
      Response response = await _dio.put(path, data: data);
      if(response.statusCode == HttpStatus.OK) {
        // 利用BaseEntity将response.data转换为对应的实体类
        T resultEntity = entity.fromJsonMap(response.data);
        assert(resultEntity is T);
        return resultEntity;
      }else {
        // 返回码不是200则抛出异常
        throw NetError(response.statusCode, response.data.toString());
      }
    }catch (exception) {
      //整个过程捕获到异常也会抛出异常
      throw NetError(NetError.unKnowErrorCode, exception.toString());
    }
  }

  @override
  void addHeader(String key, header) {
    _dio.options.headers[key] = header;
  }

  @override
  Map<String, dynamic> getHeader() {
    return _dio.options.headers;
  }

  @override
  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  @override
  void setConnectTimeout(int connectTimeout) {
    _dio.options.connectTimeout = connectTimeout;
  }

  @override
  void setReceiveTimeout(int receiveTimeout) {
    _dio.options.receiveTimeout = receiveTimeout;
  }
}