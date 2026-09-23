import 'package:dio/dio.dart';
import 'app_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'خطای نامشخص رخ داده است.';

    final statusCode = err.response?.statusCode;
    final data = err.response?.data;

    final serverMessage =
        data?['error']?['errorMessage'] ??
            data?['message'];

    if (serverMessage != null &&
        serverMessage.toString().trim().isNotEmpty) {
      errorMessage = serverMessage.toString();
    } else {
      switch (statusCode) {
        case 400:
          errorMessage = 'درخواست نامعتبر است.';
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
          errorMessage = 'خطا در اعتبارسنجی داده‌ها.';
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
          errorMessage = 'خطایی با کد $statusCode رخ داده است.';
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
