import 'package:get_it/get_it.dart';
import '../../Features/OTP_Code_Page/Data/DataSources/Request_otp_code_again_remote_data_source.dart';
import '../../Features/OTP_Code_Page/Data/DataSources/otp_code_check_remote_data_source.dart';
import '../../Features/OTP_Code_Page/Data/Repositories/otp_code_check_repository_impl.dart';
import '../../Features/OTP_Code_Page/Data/Repositories/request_otp_code_again_repository_impl.dart';
import '../../Features/OTP_Code_Page/Domain/Repositories/otp_code_check_repository.dart';
import '../../Features/OTP_Code_Page/Domain/Repositories/request_otp_code_again_repository.dart';
import '../../Features/OTP_Code_Page/Domain/UseCases/otp_code_check_use_case.dart';
import '../../Features/OTP_Code_Page/Domain/UseCases/request_otp_code_again_use_case.dart';
import '../../Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_bloc.dart';
import '../../Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/request_otp_again_bloc.dart';
import '../../Features/Profile_Page/Data/Data_Sources/citizen_ekyc_status_remote_data_source.dart';
import '../../Features/Profile_Page/Data/Repositories/citizen_ekyc_status_repository_impl.dart';
import '../../Features/Profile_Page/Domain/Repositories/citizen_kyc_status_repository.dart';
import '../../Features/Profile_Page/Domain/UseCases/citizen_ekyc_status_use_case.dart';
import '../../Features/Profile_Page/Presentation/Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_bloc.dart';
import '../../Features/Statement_Page/Data/Data_Sources/statement_data_sources.dart';
import '../../Features/Statement_Page/Data/Repositories/statement_repository_impl.dart';
import '../../Features/Statement_Page/Domain/Repositories/statement_repository.dart';
import '../../Features/Statement_Page/Domain/UseCases/fetch_statement_filtered_use_case.dart';
import '../../Features/Statement_Page/Domain/UseCases/fetch_statement_use_case.dart';
import '../../Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart';
import '../Network/dio_client.dart';

final sl = GetIt.instance;

void setupDependencies() {

  // --------------------
  // Statement
  // --------------------

  sl.registerLazySingleton<DioClient>(
        () => DioClient(),
  );

  // Data Source
  sl.registerLazySingleton<StatementDataSources>(
        () => StatementDataSources(dio: sl<DioClient>().dio
        ),
  );

  // Repository
  sl.registerLazySingleton<StatementRepository>(
        () => StatementRepositoryImpl(
      statementDataSources: sl<StatementDataSources>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<FetchStatementUseCase>(
        () => FetchStatementUseCase(
      repository: sl<StatementRepository>(),
    ),
  );

  sl.registerLazySingleton<FetchStatementFilteredUseCase>(
        () => FetchStatementFilteredUseCase(
      repository: sl<StatementRepository>(),
    ),
  );

  // Bloc
  sl.registerFactory<StatementBloc>(
        () => StatementBloc(
      sl<FetchStatementFilteredUseCase>(),
      sl<FetchStatementUseCase>(),
    ),
  );

  // --------------------
  // Profile - Citizen EKYC Status
  // --------------------

  sl.registerLazySingleton<CitizenEkycStatusRemoteDataSource>(
        () => CitizenEkycStatusRemoteDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<GetCitizenEKYCStatusRepository>(
        () => CitizenEkycStatusRepositoryImpl(
      citizenEkycStatusRemoteDataSource:
      sl<CitizenEkycStatusRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<CitizenEkycStatusUseCase>(
        () => CitizenEkycStatusUseCase(
      repository: sl<GetCitizenEKYCStatusRepository>(),
    ),
  );

  sl.registerFactory<CitizenEkycStatusBloc>(
        () => CitizenEkycStatusBloc(
      citizenEkycStatusUseCase: sl<CitizenEkycStatusUseCase>(),
    ),
  );

  // --------------------
// OTP Code
// --------------------

  sl.registerLazySingleton<OtpCodeCheckRemoteDataSource>(
        () => OtpCodeCheckRemoteDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<OtpCodeCheckRepository>(
        () => OtpCodeCheckRepositoryImpl(
      otpCodeCheckRemoteDataSource:
      sl<OtpCodeCheckRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<OtpCodeCheckUseCase>(
        () => OtpCodeCheckUseCase(
      repository: sl<OtpCodeCheckRepository>(),
    ),
  );

  sl.registerFactory<OtpCodeCheckBloc>(
        () => OtpCodeCheckBloc(
      otpCodeCheckUseCase: sl<OtpCodeCheckUseCase>(),
    ),
  );

  // --------------------
// OTP Code Again
// --------------------

  sl.registerLazySingleton<RequestOtpCodeAgainRemoteDataSource>(
        () => RequestOtpCodeAgainRemoteDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<RequestOtpCodeAgainRepository>(
        () => RequestOtpCodeAgainRepositoryImpl(
      requestOtpCodeAgainRemoteDataSource:
      sl<RequestOtpCodeAgainRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<RequestOtpCodeAgainUseCase>(
        () => RequestOtpCodeAgainUseCase(
      repository: sl<RequestOtpCodeAgainRepository>(),
    ),
  );

  sl.registerFactory<RequestOtpAgainBloc>(
        () => RequestOtpAgainBloc(
      requestOtpCodeAgainUseCase:
      sl<RequestOtpCodeAgainUseCase>(),
    ),
  );
}