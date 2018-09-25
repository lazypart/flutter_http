/// 网络错误异常
class NetError extends Error{
  static final unKnowErrorCode = -100; //未知错误码

  final message;
  final code;

  NetError(this.code, this.message);

  String toString() {
    return "Net error:code=$code,message=$message";
  }
}