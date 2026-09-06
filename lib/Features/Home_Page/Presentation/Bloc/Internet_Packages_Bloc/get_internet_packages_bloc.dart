import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/UseCases/internet_package_use_case.dart';
import 'get_internet_packages_event.dart';
import 'get_internet_packages_state.dart';

class InternetPackageBloc extends Bloc<InternetPackageEvent, InternetPackageState> {
  final InternetPackageUseCase internetPackageUseCase;

  InternetPackageBloc({required this.internetPackageUseCase}) : super(InternetPackageState.initial()) {
    on<FetchAllInternetPackages>(_onFetchAllInternetPackages);
    on<FetchInternetPackages>(_onFetchInternetPackages);
    on<BuyInternetPackage>(_onBuyInternetPackage);
    on<ResetBuyStatus>(_onResetBuyStatus);
  }

  Future<void> _onFetchAllInternetPackages(
      FetchAllInternetPackages event,
      Emitter<InternetPackageState> emit,
      ) async {
    try {
      emit(state.copyWith(status: InternetPackageStatus.loading));

      final internetPackages = await internetPackageUseCase.getAllInternetPackages(event.operatorCode);

      print('📦 تعداد بسته‌های دریافت شده: ${internetPackages.length}');

      emit(state.copyWith(
        status: InternetPackageStatus.success,
        internetPackages: internetPackages,
        errorMessage: null,
      ));
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      emit(state.copyWith(
        status: InternetPackageStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    } catch (error) {
      print('❌ Error: $error');
      emit(state.copyWith(
        status: InternetPackageStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onFetchInternetPackages(
      FetchInternetPackages event,
      Emitter<InternetPackageState> emit,
      ) async {
    try {
      emit(state.copyWith(status: InternetPackageStatus.loading));

      final internetPackages = await internetPackageUseCase.getInternetPackages(
        operatorCode: event.operatorCode,
        packageTimeCode: event.packageTimeCode,
        simType: event.simType,
        traffic: event.traffic,
      );

      print('📦 تعداد بسته‌های فیلتر شده: ${internetPackages.length}');

      emit(state.copyWith(
        status: InternetPackageStatus.success,
        internetPackages: internetPackages,
        errorMessage: null,
      ));
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      emit(state.copyWith(
        status: InternetPackageStatus.error,
        errorMessage: _getErrorMessage(e),
      ));
    } catch (error) {
      print('❌ Error: $error');
      emit(state.copyWith(
        status: InternetPackageStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onBuyInternetPackage(
      BuyInternetPackage event,
      Emitter<InternetPackageState> emit,
      ) async {
    try {
      emit(state.copyWith(
        buyStatus: BuyStatus.loading,
        errorMessage: null,
        errorCode: null,
        buyResult: null,
      ));

      final result = await internetPackageUseCase.buyInternetPackage(
        sourceMobileNumber: event.sourceMobileNumber,
        walletAddress: event.walletAddress,
        productCode: event.productCode,
        destMobileNumber: event.destMobileNumber,
      );

      if (result.isSuccess) {
        emit(state.copyWith(
          buyStatus: BuyStatus.success,
          buyResult: result.dataString ?? result.message ?? 'خرید با موفقیت انجام شد',
          errorMessage: null,
          errorCode: null,
        ));
      } else {
        emit(state.copyWith(
          buyStatus: BuyStatus.error,
          errorMessage: result.displayMessage,
          errorCode: result.error?.errorCode,
          buyResult: null,
        ));
      }
    } catch (e) {
      print('❌ خطا در خرید: $e');
      emit(state.copyWith(
        buyStatus: BuyStatus.error,
        errorMessage: 'خطای ناشناخته رخ داده است',
        errorCode: null,
        buyResult: null,
      ));
    }
  }

  void _onResetBuyStatus(
      ResetBuyStatus event,
      Emitter<InternetPackageState> emit,
      ) {
    emit(state.copyWith(
      buyStatus: BuyStatus.idle,
      errorMessage: null,
      errorCode: null,
      buyResult: null,
    ));
  }

  String _getErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'زمان ارتباط با سرور به پایان رسید';
      case DioExceptionType.receiveTimeout:
        return 'سرور پاسخ نمی‌دهد';
      case DioExceptionType.sendTimeout:
        return 'خطا در ارسال درخواست';
      case DioExceptionType.connectionError:
        return 'لطفاً اتصال اینترنت خود را بررسی کنید';
      case DioExceptionType.cancel:
        return 'درخواست لغو شد';
      default:
        if (e.response?.statusCode != null) {
          return 'خطای سرور: کد خطا ${e.response!.statusCode}';
        }
        return 'خطا در ارتباط با سرور';
    }
  }
}