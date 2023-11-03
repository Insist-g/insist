import 'package:dio/dio.dart';
import 'package:flutter_ducafecat_news_getx/common/store/user.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/loading.dart';
import 'package:flutter_ducafecat_news_getx/common/values/server.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'http.dart';

class HttpInterceptor implements InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Do something with response error
    Loading.dismiss();
    handlerError(createErrorEntity(err));
    return handler.reject(err); //continue
    // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
    // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
  }

  @override
  void onRequest(options, handler) async {
    // Do something before request is sent
    return handler.next(options); //continue
    // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
    // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    //
    // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
    // 这样请求将被中止并触发异常，上层catchError会被调用。
  }

  @override
  void onResponse(response, handler) {
    // 统一处理业务状态码，只返回业务数据 data
    final data = response.data;
    int? code = data['code'];
    final msg = data['msg'];
    if (code == RSP_OK) {
      return handler.next(response);
    } else {
      response.statusCode = code;
      final error = DioException(
        type: DioExceptionType.badResponse,
        requestOptions: response.requestOptions,
        response: response
          ..statusCode = code
          ..statusMessage = msg,
        error: data['msg'],
      );
      if (code == NEED_LOGIN) {
        if (response.requestOptions.path.toString().contains("logout")) {
          return;
        }
        UserStore.to.onLogout();
        return;
      }
      return handler.resolve(response);
      return handler.reject(error);
    }
  }

  // 错误信息
  ErrorEntity createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -1, message: "连接超时");
      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -1, message: "请求超时");
      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -1, message: "响应超时");
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: "请求取消");
      case DioExceptionType.connectionError:
        return ErrorEntity(code: -1, message: "连接错误");
      case DioExceptionType.badResponse:
        {
          try {
            int errCode =
                error.response != null ? error.response!.statusCode! : -1;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "请求语法错误");
              case 401:
                return ErrorEntity(code: errCode, message: "没有权限");
              case 403:
                return ErrorEntity(code: errCode, message: "服务器拒绝执行");
              case 404:
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              case 405:
                return ErrorEntity(code: errCode, message: "请求方法被禁止");
              case 500:
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              case 502:
                return ErrorEntity(code: errCode, message: "无效的请求");
              case 503:
                return ErrorEntity(code: errCode, message: "服务器挂了");
              case 505:
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return ErrorEntity(
                    code: errCode,
                    message: error.response != null
                        ? error.response!.statusMessage!
                        : "",
                  );
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message ?? '未知错误');
        }
    }
  }

  // 错误处理
  void handlerError(ErrorEntity eInfo) {
    print('error.code -> ' +
        eInfo.code.toString() +
        ', error.message -> ' +
        eInfo.message);
    switch (eInfo.code) {
      case NEED_LOGIN:
        UserStore.to.onLogout();
        break;
      default:
        break;
    }
    EasyLoading.showError(eInfo.message);
  }
}
