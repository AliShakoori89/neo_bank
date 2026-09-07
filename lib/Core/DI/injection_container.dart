import 'package:get_it/get_it.dart';
import '../../Features/Account_Page/Data/Data_Sources/auth_remote_data_source.dart';
import '../../Features/Account_Page/Data/Repositories/user_login_auth_repository_impl.dart';
import '../../Features/Account_Page/Domain/Repositories/user_login_auth_repository.dart';
import '../../Features/Account_Page/Domain/UseCases/check_login_status_use_case.dart';
import '../../Features/Account_Page/Domain/UseCases/login_use_case.dart';
import '../../Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart';
import '../../Features/Fund_Transfer_Page/Data/DataSources/all_card_detail_remote_data_source.dart';
import '../../Features/Fund_Transfer_Page/Data/DataSources/deposit_remote_data_source.dart';
import '../../Features/Fund_Transfer_Page/Data/Repositories/all_card_detail_repository_impl.dart';
import '../../Features/Fund_Transfer_Page/Data/Repositories/deposits_repository_impl.dart';
import '../../Features/Fund_Transfer_Page/Domain/Repositories/all_card_detail_repository.dart';
import '../../Features/Fund_Transfer_Page/Domain/Repositories/deposits_repository.dart';
import '../../Features/Fund_Transfer_Page/Domain/UseCases/all_card_detail_use_case.dart';
import '../../Features/Fund_Transfer_Page/Domain/UseCases/deposit_use_case.dart';
import '../../Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_bloc.dart';
import '../../Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart';
import '../../Features/Home_Page/Data/Data_Sources/all_card_data_source.dart';
import '../../Features/Home_Page/Data/Data_Sources/internet_packages_data_sources.dart';
import '../../Features/Home_Page/Data/Data_Sources/last_transaction_data_source.dart';
import '../../Features/Home_Page/Data/Data_Sources/loan_page_data_source.dart';
import '../../Features/Home_Page/Data/Data_Sources/transaction_data_source.dart';
import '../../Features/Home_Page/Data/Data_Sources/wallet_data_source.dart';
import '../../Features/Home_Page/Data/Repositories/all_card_repository_impl.dart';
import '../../Features/Home_Page/Data/Repositories/internet_package_repository_impl.dart';
import '../../Features/Home_Page/Data/Repositories/last_transaction_repository_impl.dart';
import '../../Features/Home_Page/Data/Repositories/loan_page_repository_impl.dart';
import '../../Features/Home_Page/Data/Repositories/transaction_repository_impl.dart';
import '../../Features/Home_Page/Data/Repositories/wallet_repository_impl.dart';
import '../../Features/Home_Page/Domain/Repositories/all_card_repository.dart';
import '../../Features/Home_Page/Domain/Repositories/internet_packages_repository.dart';
import '../../Features/Home_Page/Domain/Repositories/last_transaction_repository.dart';
import '../../Features/Home_Page/Domain/Repositories/loan_page_repository.dart';
import '../../Features/Home_Page/Domain/Repositories/transaction_repository.dart';
import '../../Features/Home_Page/Domain/Repositories/wallet_repository.dart';
import '../../Features/Home_Page/Domain/UseCases/all_cards_use_case.dart';
import '../../Features/Home_Page/Domain/UseCases/internet_package_use_case.dart';
import '../../Features/Home_Page/Domain/UseCases/last_transaction_use_case.dart';
import '../../Features/Home_Page/Domain/UseCases/loan_page_use_case.dart';
import '../../Features/Home_Page/Domain/UseCases/transaction_use_case.dart';
import '../../Features/Home_Page/Domain/UseCases/wallet_use_case.dart';
import '../../Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_bloc.dart';
import '../../Features/Home_Page/Presentation/Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart';
import '../../Features/Home_Page/Presentation/Bloc/Last_Transaction_Bloc/last_transaction_bloc.dart';
import '../../Features/Home_Page/Presentation/Bloc/Loan_Page_Bloc/loan_page_bloc.dart';
import '../../Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_bloc.dart';
import '../../Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_bloc.dart';
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

  // --------------------
// Home - All Cards
// --------------------

  sl.registerLazySingleton<AllCardDataSource>(
        () => AllCardDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<AllCardRepository>(
        () => AllCardRepositoryImpl(
      allCardDataSources: sl<AllCardDataSource>(),
    ),
  );

  sl.registerLazySingleton<AllCardsUseCase>(
        () => AllCardsUseCase(
      allCardRepository: sl<AllCardRepository>(),
    ),
  );

  sl.registerFactory<AllCardsBloc>(
        () => AllCardsBloc(
      allCardsUseCase: sl<AllCardsUseCase>(),
    ),
  );

  // ==================== Internet Packages ====================

  sl.registerLazySingleton<InternetPackagesDataSources>(
        () => InternetPackagesDataSources(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<InternetPackagesRepository>(
        () => InternetPackageRepositoryImpl(
      internetPackagesDataSources:
      sl<InternetPackagesDataSources>(),
    ),
  );

  sl.registerLazySingleton<InternetPackageUseCase>(
        () => InternetPackageUseCase(
      repository: sl<InternetPackagesRepository>(),
    ),
  );

  sl.registerFactory<InternetPackageBloc>(
        () => InternetPackageBloc(
      internetPackageUseCase:
      sl<InternetPackageUseCase>(),
    ),
  );

  // ==================== Last Transaction ====================

  sl.registerLazySingleton<LastTransactionDataSource>(
        () => LastTransactionDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<LastTransactionRepository>(
        () => LastTransactionRepositoryImpl(
      lastTransactionDataSource:
      sl<LastTransactionDataSource>(),
    ),
  );

  sl.registerLazySingleton<LastTransactionUseCase>(
        () => LastTransactionUseCase(
      lastTransactionRepository:
      sl<LastTransactionRepository>(),
    ),
  );

  sl.registerFactory<LastTransactionBloc>(
        () => LastTransactionBloc(
      lastTransactionUseCase:
      sl<LastTransactionUseCase>(),
    ),
  );

  // ==================== Loan Page ====================

  sl.registerLazySingleton<LoanPageDataSource>(
        () => LoanPageDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<LoanPageRepository>(
        () => LoanPageRepositoryImpl(
      loanPageDataSource:
      sl<LoanPageDataSource>(),
    ),
  );

  sl.registerLazySingleton<LoanPageUseCase>(
        () => LoanPageUseCase(
      loanPageRepository:
      sl<LoanPageRepository>(),
    ),
  );

  sl.registerFactory<LoanPageBloc>(
        () => LoanPageBloc(
      loanPageUseCase:
      sl<LoanPageUseCase>(),
    ),
  );

  // ==================== Transaction ====================

  sl.registerLazySingleton<TransactionDataSource>(
        () => TransactionDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<TransactionRepository>(
        () => TransactionRepositoryImpl(
      transactionDataSource:
      sl<TransactionDataSource>(),
    ),
  );

  sl.registerLazySingleton<TransactionUseCase>(
        () => TransactionUseCase(
      transactionRepository:
      sl<TransactionRepository>(),
    ),
  );

  sl.registerFactory<TransactionBloc>(
        () => TransactionBloc(
      transactionUseCase:
      sl<TransactionUseCase>(),
    ),
  );

  // ==================== Wallet ====================

  sl.registerLazySingleton<WalletDataSource>(
        () => WalletDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<WalletRepository>(
        () => WalletRepositoryImpl(
      walletDataSource:
      sl<WalletDataSource>(),
    ),
  );

  sl.registerLazySingleton<WalletUseCase>(
        () => WalletUseCase(
      walletRepository:
      sl<WalletRepository>(),
    ),
  );

  sl.registerFactory<WalletBloc>(
        () => WalletBloc(
      walletUseCase:
      sl<WalletUseCase>(),
    ),
  );

  // ==================== All Card Details ====================

  sl.registerLazySingleton<AllCardDetailRemoteDataSource>(
        () => AllCardDetailRemoteDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<AllCardDetailRepository>(
        () => AllCardDetailRepositoryImpl(
      allCardDetailRemoteDataSource:
      sl<AllCardDetailRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<AllCardDetailUseCase>(
        () => AllCardDetailUseCase(
      repository:
      sl<AllCardDetailRepository>(),
    ),
  );

  sl.registerFactory<AllCardsDetailBloc>(
        () => AllCardsDetailBloc(
      allCardDetailUseCase:
      sl<AllCardDetailUseCase>(),
    ),
  );

  // ==================== Deposit ====================


  sl.registerLazySingleton<DepositRemoteDataSource>(
        () => DepositRemoteDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<DepositsRepository>(
        () => DepositsRepositoryImpl(
      depositRemoteDataSource:
      sl<DepositRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<DepositUseCase>(
        () => DepositUseCase(
      repository:
      sl<DepositsRepository>(),
    ),
  );

  sl.registerFactory<UserAllAccountBloc>(
        () => UserAllAccountBloc(
      depositUseCase:
      sl<DepositUseCase>(),
    ),
  );

  // ==================== User Login Auth ====================


  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(
      dio: sl<DioClient>().dio,
    ),
  );

  sl.registerLazySingleton<UserLoginAuthRepository>(
        () => UserLoginAuthRepositoryImpl(
      remoteDataSource:
      sl<AuthRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(
      repository:
      sl<UserLoginAuthRepository>(),
    ),
  );

  sl.registerLazySingleton<CheckLoginStatusUseCase>(
        () => CheckLoginStatusUseCase(
      repository:
      sl<UserLoginAuthRepository>(),
    ),
  );

  sl.registerFactory<UserLoginAuthBloc>(
        () => UserLoginAuthBloc(
      loginUseCase:
      sl<LoginUseCase>(),
      checkLoginStatusUseCase:
      sl<CheckLoginStatusUseCase>(),
    ),
  );
}