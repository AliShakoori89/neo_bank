import 'package:dio/dio.dart';
import 'app_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'خطای نامشخص رخ داده است.';

    if (err.response != null) {
      final statusCode = err.response?.statusCode;
      final data = err.response?.data;

      switch (statusCode) {
        case 400:
          errorMessage = data?['message'] ?? data?['error']?['errorMessage'] ?? 'درخواست نامعتبر است.';
          break;
        case 401:
          errorMessage = 'نشست شما منقضی شده است. لطفا دوباره وارد شوید.';
          break;
        case 403:
          errorMessage = 'شما اجازه دسترسی به این بخش را ندارید.';
          break;
        case 404:
          errorMessage = 'سرویس مورد نظر یافت نشد.';
          break;
        case 422:
          errorMessage = data?['error']?['errorMessage'] ?? 'خطا در اعتبارسنجی داده‌ها.';
          break;
        case 500:
          errorMessage = 'خطای سرور داخلی. لطفا بعدا تلاش کنید.';
          break;
        case 502:
          errorMessage = 'خطا در برقراری ارتباط با درگاه سرویس.';
          break;
        case 503:
          errorMessage = 'سرویس در دسترس نیست.';
          break;
        case 504:
          errorMessage = 'زمان پاسخگویی سرور به پایان رسید.';
          break;
        default:
          errorMessage = data?['message'] ?? data?['error']?['errorMessage'] ?? 'خطایی با کد $statusCode رخ داده است.';
      }
    } else {
      switch (err.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          errorMessage = 'خطای وقفه در اتصال. لطفا اینترنت خود را بررسی کنید.';
          break;
        case DioExceptionType.connectionError:
          errorMessage = 'خطا در اتصال به شبکه.';
          break;
        case DioExceptionType.cancel:
          errorMessage = 'درخواست لغو شد.';
          break;
        default:
          errorMessage = 'خطا در برقراری ارتباط با سرور.';
      }
    }

    // We pass the AppException inside the DioException
    return handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: AppException(errorMessage),
      ),
    );
  }
}
