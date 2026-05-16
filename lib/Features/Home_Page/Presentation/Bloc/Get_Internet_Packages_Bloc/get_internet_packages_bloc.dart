import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Charge_Internet_Page/Domain/get_internet_packages_repo.dart';
import 'get_internet_packages_event.dart';
import 'get_internet_packages_state.dart';

class InternetPackageBloc extends Bloc<InternetPackageEvent, InternetPackageState> {
  final InternetPackagesRepository internetPackagesRepository;

  InternetPackageBloc( this.internetPackagesRepository) : super(InternetPackageState.initial()) {
    on<FetchInternetPackages>(_onFetchInternetPackages);
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

}