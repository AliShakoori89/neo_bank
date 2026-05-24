import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repository/internet_packages_repository.dart';
import 'get_internet_packages_event.dart';
import 'get_internet_packages_state.dart';

class InternetPackageBloc extends Bloc<InternetPackageEvent, InternetPackageState> {
  final InternetPackagesRepository internetPackagesRepository;

  InternetPackageBloc( this.internetPackagesRepository) : super(InternetPackageState.initial()) {
    on<FetchAllInternetPackages>(_onFetchAllInternetPackages);
    on<FetchInternetPackages>(_onFetchInternetPackages);
    on<BuyInternetPackage>(_onBuyInternetPackage);  // اضافه کردن هندلر خرید
    on<ResetBuyStatus>(_onResetBuyStatus);          // اضافه کردن هندلر ریست
  }

  void _onFetchAllInternetPackages(
      FetchAllInternetPackages event,
      Emitter<InternetPackageState> emit,
      ) async {
    try {
      emit(state.copyWith(status: InternetPackageStatus.loading));

      final internetPackage = await internetPackagesRepository.getAllInternetPackages(event.operatorCode);
      print(internetPackage);

      emit(
        state.copyWith(status: InternetPackageStatus.success, internetPackages: internetPackage),
      );
    } on DioException catch (e) {

      emit(state.copyWith(status: InternetPackageStatus.error));

    } catch (error) {
      emit(state.copyWith(status: InternetPackageStatus.error));
    }
  }

  void _onFetchInternetPackages(
      FetchInternetPackages event,
      Emitter<InternetPackageState> emit,
      ) async {
    try {
      emit(state.copyWith(status: InternetPackageStatus.loading));

      final internetPackage = await internetPackagesRepository.getInternetPackages(event.operatorCode, event.packageTimeCode, event.simType, event.traffic);
      print(internetPackage);

      emit(
        state.copyWith(status: InternetPackageStatus.success, internetPackages: internetPackage),
      );
    } on DioException catch (e) {

      emit(state.copyWith(status: InternetPackageStatus.error));

    } catch (error) {
      emit(state.copyWith(status: InternetPackageStatus.error));
    }
  }

  // هندلر خرید بسته اینترنت
  Future<void> _onBuyInternetPackage(
      BuyInternetPackage event,
      Emitter<InternetPackageState> emit,
      ) async {
    try {
      // تغییر وضعیت به در حال خرید
      emit(state.copyWith(
        buyStatus: BuyStatus.loading,
        errorMessage: null,
        errorCode: null,
        buyResult: null,
      ));

      final result = await internetPackagesRepository.buyInternetPackage(
        event.sourceMobileNumber,
        event.walletAddress,
        event.productCode,
        event.destMobileNumber,
      );

      if (result.isSuccess) {
        // خرید موفق
        emit(state.copyWith(
          buyStatus: BuyStatus.success,
          buyResult: result.data ?? 'خرید با موفقیت انجام شد',
          errorMessage: null,
          errorCode: null,
        ));
      }
      else if (result.isFailure) {
        // خطای تجاری (مثل 5001)
        emit(state.copyWith(
          buyStatus: BuyStatus.failure,
          errorMessage: result.errorModel?.errorMessage,
          errorCode: result.errorModel?.errorCode,
          buyResult: null,
        ));
      }
      else if (result.isError) {
        // خطای فنی
        emit(state.copyWith(
          buyStatus: BuyStatus.error,
          errorMessage: result.errorMessage,
          errorCode: null,
          buyResult: null,
        ));
      }
    } catch (e) {
      // خطای پیش‌بینی نشده
      emit(state.copyWith(
        buyStatus: BuyStatus.error,
        errorMessage: 'خطای ناشناخته رخ داده است',
        errorCode: null,
        buyResult: null,
      ));
    }
  }

  // ریست کردن وضعیت خرید
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
}