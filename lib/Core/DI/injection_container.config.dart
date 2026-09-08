// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:neo_bank/Core/Network/dio_client.dart' as _i652;
import 'package:neo_bank/Features/Account_Page/Data/Data_Sources/auth_remote_data_source.dart'
    as _i928;
import 'package:neo_bank/Features/Account_Page/Data/Repositories/user_login_auth_repository_impl.dart'
    as _i849;
import 'package:neo_bank/Features/Account_Page/Domain/Repositories/user_login_auth_repository.dart'
    as _i388;
import 'package:neo_bank/Features/Account_Page/Domain/UseCases/check_login_status_use_case.dart'
    as _i606;
import 'package:neo_bank/Features/Account_Page/Domain/UseCases/login_use_case.dart'
    as _i373;
import 'package:neo_bank/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart'
    as _i963;
import 'package:neo_bank/Features/Fund_Transfer_Page/Data/DataSources/all_card_detail_remote_data_source.dart'
    as _i143;
import 'package:neo_bank/Features/Fund_Transfer_Page/Data/DataSources/deposit_remote_data_source.dart'
    as _i389;
import 'package:neo_bank/Features/Fund_Transfer_Page/Data/Repositories/all_card_detail_repository_impl.dart'
    as _i357;
import 'package:neo_bank/Features/Fund_Transfer_Page/Data/Repositories/deposits_repository_impl.dart'
    as _i916;
import 'package:neo_bank/Features/Fund_Transfer_Page/Domain/Repositories/all_card_detail_repository.dart'
    as _i423;
import 'package:neo_bank/Features/Fund_Transfer_Page/Domain/Repositories/deposits_repository.dart'
    as _i164;
import 'package:neo_bank/Features/Fund_Transfer_Page/Domain/UseCases/all_card_detail_use_case.dart'
    as _i213;
import 'package:neo_bank/Features/Fund_Transfer_Page/Domain/UseCases/deposit_use_case.dart'
    as _i561;
import 'package:neo_bank/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_bloc.dart'
    as _i190;
import 'package:neo_bank/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart'
    as _i722;
import 'package:neo_bank/Features/Home_Page/Data/Data_Sources/all_card_data_source.dart'
    as _i372;
import 'package:neo_bank/Features/Home_Page/Data/Data_Sources/internet_packages_data_sources.dart'
    as _i826;
import 'package:neo_bank/Features/Home_Page/Data/Data_Sources/loan_page_data_source.dart'
    as _i192;
import 'package:neo_bank/Features/Home_Page/Data/Data_Sources/transaction_data_source.dart'
    as _i506;
import 'package:neo_bank/Features/Home_Page/Data/Data_Sources/wallet_data_source.dart'
    as _i113;
import 'package:neo_bank/Features/Home_Page/Data/Repositories/all_card_repository_impl.dart'
    as _i549;
import 'package:neo_bank/Features/Home_Page/Data/Repositories/internet_package_repository_impl.dart'
    as _i576;
import 'package:neo_bank/Features/Home_Page/Data/Repositories/loan_page_repository_impl.dart'
    as _i28;
import 'package:neo_bank/Features/Home_Page/Data/Repositories/transaction_repository_impl.dart'
    as _i859;
import 'package:neo_bank/Features/Home_Page/Data/Repositories/wallet_repository_impl.dart'
    as _i505;
import 'package:neo_bank/Features/Home_Page/Domain/Repositories/all_card_repository.dart'
    as _i110;
import 'package:neo_bank/Features/Home_Page/Domain/Repositories/internet_packages_repository.dart'
    as _i332;
import 'package:neo_bank/Features/Home_Page/Domain/Repositories/loan_page_repository.dart'
    as _i51;
import 'package:neo_bank/Features/Home_Page/Domain/Repositories/transaction_repository.dart'
    as _i3;
import 'package:neo_bank/Features/Home_Page/Domain/Repositories/wallet_repository.dart'
    as _i496;
import 'package:neo_bank/Features/Home_Page/Domain/UseCases/all_cards_use_case.dart'
    as _i827;
import 'package:neo_bank/Features/Home_Page/Domain/UseCases/internet_package_use_case.dart'
    as _i307;
import 'package:neo_bank/Features/Home_Page/Domain/UseCases/loan_page_use_case.dart'
    as _i1028;
import 'package:neo_bank/Features/Home_Page/Domain/UseCases/transaction_use_case.dart'
    as _i620;
import 'package:neo_bank/Features/Home_Page/Domain/UseCases/wallet_use_case.dart'
    as _i211;
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_bloc.dart'
    as _i703;
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart'
    as _i221;
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Loan_Page_Bloc/loan_page_bloc.dart'
    as _i158;
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_bloc.dart'
    as _i22;
import 'package:neo_bank/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_bloc.dart'
    as _i944;
import 'package:neo_bank/Features/OTP_Code_Page/Data/DataSources/otp_code_check_remote_data_source.dart'
    as _i50;
import 'package:neo_bank/Features/OTP_Code_Page/Data/DataSources/Request_otp_code_again_remote_data_source.dart'
    as _i741;
import 'package:neo_bank/Features/OTP_Code_Page/Domain/Repositories/otp_code_check_repository.dart'
    as _i437;
import 'package:neo_bank/Features/OTP_Code_Page/Domain/Repositories/request_otp_code_again_repository.dart'
    as _i871;
import 'package:neo_bank/Features/OTP_Code_Page/Domain/UseCases/otp_code_check_use_case.dart'
    as _i746;
import 'package:neo_bank/Features/OTP_Code_Page/Domain/UseCases/request_otp_code_again_use_case.dart'
    as _i846;
import 'package:neo_bank/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_bloc.dart'
    as _i352;
import 'package:neo_bank/Features/Profile_Page/Data/Data_Sources/citizen_ekyc_status_remote_data_source.dart'
    as _i921;
import 'package:neo_bank/Features/Profile_Page/Data/Repositories/citizen_ekyc_status_repository_impl.dart'
    as _i290;
import 'package:neo_bank/Features/Profile_Page/Domain/Repositories/citizen_kyc_status_repository.dart'
    as _i874;
import 'package:neo_bank/Features/Profile_Page/Domain/UseCases/citizen_ekyc_status_use_case.dart'
    as _i208;
import 'package:neo_bank/Features/Profile_Page/Presentation/Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_bloc.dart'
    as _i488;
import 'package:neo_bank/Features/Statement_Page/Data/Data_Sources/statement_data_sources.dart'
    as _i617;
import 'package:neo_bank/Features/Statement_Page/Data/Repositories/statement_repository_impl.dart'
    as _i47;
import 'package:neo_bank/Features/Statement_Page/Domain/Repositories/statement_repository.dart'
    as _i77;
import 'package:neo_bank/Features/Statement_Page/Domain/UseCases/fetch_statement_filtered_use_case.dart'
    as _i779;
import 'package:neo_bank/Features/Statement_Page/Domain/UseCases/fetch_statement_use_case.dart'
    as _i713;
import 'package:neo_bank/Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart'
    as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i846.RequestOtpCodeAgainUseCase>(
      () => _i846.RequestOtpCodeAgainUseCase(
        repository: gh<_i871.RequestOtpCodeAgainRepository>(),
      ),
    );
    gh.lazySingleton<_i928.AuthRemoteDataSource>(
      () => _i928.AuthRemoteDataSource(dioClient: gh<_i652.DioClient>()),
    );
    gh.lazySingleton<_i143.AllCardDetailRemoteDataSource>(
      () =>
          _i143.AllCardDetailRemoteDataSource(dioClient: gh<_i652.DioClient>()),
    );
    gh.lazySingleton<_i389.DepositRemoteDataSource>(
      () => _i389.DepositRemoteDataSource(dioClient: gh<_i652.DioClient>()),
    );
    gh.lazySingleton<_i372.AllCardDataSource>(
      () => _i372.AllCardDataSource(dioClient: gh<_i652.DioClient>()),
    );
    gh.lazySingleton<_i826.InternetPackagesDataSources>(
      () => _i826.InternetPackagesDataSources(dioClient: gh<_i652.DioClient>()),
    );
    gh.lazySingleton<_i192.LoanPageDataSource>(
      () => _i192.LoanPageDataSource(dioClient: gh<_i652.DioClient>()),
    );
    gh.lazySingleton<_i506.TransactionDataSource>(
      () => _i506.TransactionDataSource(dioClient: gh<_i652.DioClient>()),
    );
    gh.lazySingleton<_i113.WalletDataSource>(
      () => _i113.WalletDataSource(dioClient: gh<_i652.DioClient>()),
    );
    gh.lazySingleton<_i741.RequestOtpCodeAgainRemoteDataSource>(
      () => _i741.RequestOtpCodeAgainRemoteDataSource(
        dioClient: gh<_i652.DioClient>(),
      ),
    );
    gh.lazySingleton<_i50.OtpCodeCheckRemoteDataSource>(
      () => _i50.OtpCodeCheckRemoteDataSource(dioClient: gh<_i652.DioClient>()),
    );
    gh.lazySingleton<_i921.CitizenEkycStatusRemoteDataSource>(
      () => _i921.CitizenEkycStatusRemoteDataSource(
        dioClient: gh<_i652.DioClient>(),
      ),
    );
    gh.lazySingleton<_i617.StatementDataSources>(
      () => _i617.StatementDataSources(dioClient: gh<_i652.DioClient>()),
    );
    gh.lazySingleton<_i164.DepositsRepository>(
      () => _i916.DepositsRepositoryImpl(
        depositRemoteDataSource: gh<_i389.DepositRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i746.OtpCodeCheckUseCase>(
      () => _i746.OtpCodeCheckUseCase(
        repository: gh<_i437.OtpCodeCheckRepository>(),
      ),
    );
    gh.lazySingleton<_i77.StatementRepository>(
      () => _i47.StatementRepositoryImpl(
        statementDataSources: gh<_i617.StatementDataSources>(),
      ),
    );
    gh.lazySingleton<_i779.FetchStatementFilteredUseCase>(
      () => _i779.FetchStatementFilteredUseCase(
        repository: gh<_i77.StatementRepository>(),
      ),
    );
    gh.lazySingleton<_i713.FetchStatementUseCase>(
      () => _i713.FetchStatementUseCase(
        repository: gh<_i77.StatementRepository>(),
      ),
    );
    gh.lazySingleton<_i51.LoanPageRepository>(
      () => _i28.LoanPageRepositoryImpl(
        loanPageDataSource: gh<_i192.LoanPageDataSource>(),
      ),
    );
    gh.lazySingleton<_i464.StatementBloc>(
      () => _i464.StatementBloc(
        gh<_i779.FetchStatementFilteredUseCase>(),
        gh<_i713.FetchStatementUseCase>(),
      ),
    );
    gh.lazySingleton<_i874.GetCitizenEKYCStatusRepository>(
      () => _i290.CitizenEkycStatusRepositoryImpl(
        citizenEkycStatusRemoteDataSource:
            gh<_i921.CitizenEkycStatusRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i208.CitizenEkycStatusUseCase>(
      () => _i208.CitizenEkycStatusUseCase(
        repository: gh<_i874.GetCitizenEKYCStatusRepository>(),
      ),
    );
    gh.lazySingleton<_i3.TransactionRepository>(
      () => _i859.TransactionRepositoryImpl(
        transactionDataSource: gh<_i506.TransactionDataSource>(),
      ),
    );
    gh.lazySingleton<_i423.AllCardDetailRepository>(
      () => _i357.AllCardDetailRepositoryImpl(
        allCardDetailRemoteDataSource:
            gh<_i143.AllCardDetailRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i561.DepositUseCase>(
      () => _i561.DepositUseCase(repository: gh<_i164.DepositsRepository>()),
    );
    gh.lazySingleton<_i496.WalletRepository>(
      () => _i505.WalletRepositoryImpl(
        walletDataSource: gh<_i113.WalletDataSource>(),
      ),
    );
    gh.lazySingleton<_i332.InternetPackagesRepository>(
      () => _i576.InternetPackageRepositoryImpl(
        internetPackagesDataSources: gh<_i826.InternetPackagesDataSources>(),
      ),
    );
    gh.lazySingleton<_i307.InternetPackageUseCase>(
      () => _i307.InternetPackageUseCase(
        repository: gh<_i332.InternetPackagesRepository>(),
      ),
    );
    gh.lazySingleton<_i213.AllCardDetailUseCase>(
      () => _i213.AllCardDetailUseCase(
        repository: gh<_i423.AllCardDetailRepository>(),
      ),
    );
    gh.lazySingleton<_i388.UserLoginAuthRepository>(
      () => _i849.UserLoginAuthRepositoryImpl(
        remoteDataSource: gh<_i928.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i722.AllCardsDetailBloc>(
      () => _i722.AllCardsDetailBloc(
        allCardDetailUseCase: gh<_i213.AllCardDetailUseCase>(),
      ),
    );
    gh.lazySingleton<_i110.AllCardRepository>(
      () => _i549.AllCardRepositoryImpl(
        allCardDataSources: gh<_i372.AllCardDataSource>(),
      ),
    );
    gh.lazySingleton<_i352.OtpCodeCheckBloc>(
      () => _i352.OtpCodeCheckBloc(
        otpCodeCheckUseCase: gh<_i746.OtpCodeCheckUseCase>(),
      ),
    );
    gh.lazySingleton<_i221.InternetPackageBloc>(
      () => _i221.InternetPackageBloc(
        internetPackageUseCase: gh<_i307.InternetPackageUseCase>(),
      ),
    );
    gh.lazySingleton<_i827.AllCardsUseCase>(
      () => _i827.AllCardsUseCase(
        allCardRepository: gh<_i110.AllCardRepository>(),
      ),
    );
    gh.lazySingleton<_i1028.LoanPageUseCase>(
      () => _i1028.LoanPageUseCase(
        loanPageRepository: gh<_i51.LoanPageRepository>(),
      ),
    );
    gh.lazySingleton<_i620.TransactionUseCase>(
      () => _i620.TransactionUseCase(
        transactionRepository: gh<_i3.TransactionRepository>(),
      ),
    );
    gh.lazySingleton<_i606.CheckLoginStatusUseCase>(
      () => _i606.CheckLoginStatusUseCase(
        repository: gh<_i388.UserLoginAuthRepository>(),
      ),
    );
    gh.lazySingleton<_i373.LoginUseCase>(
      () => _i373.LoginUseCase(repository: gh<_i388.UserLoginAuthRepository>()),
    );
    gh.lazySingleton<_i488.CitizenEkycStatusBloc>(
      () => _i488.CitizenEkycStatusBloc(
        citizenEkycStatusUseCase: gh<_i208.CitizenEkycStatusUseCase>(),
      ),
    );
    gh.lazySingleton<_i158.LoanPageBloc>(
      () => _i158.LoanPageBloc(loanPageUseCase: gh<_i1028.LoanPageUseCase>()),
    );
    gh.lazySingleton<_i211.WalletUseCase>(
      () => _i211.WalletUseCase(walletRepository: gh<_i496.WalletRepository>()),
    );
    gh.lazySingleton<_i22.TransactionBloc>(
      () => _i22.TransactionBloc(
        transactionUseCase: gh<_i620.TransactionUseCase>(),
      ),
    );
    gh.lazySingleton<_i190.UserAllAccountBloc>(
      () =>
          _i190.UserAllAccountBloc(depositUseCase: gh<_i561.DepositUseCase>()),
    );
    gh.lazySingleton<_i703.AllCardsBloc>(
      () => _i703.AllCardsBloc(allCardsUseCase: gh<_i827.AllCardsUseCase>()),
    );
    gh.lazySingleton<_i963.UserLoginAuthBloc>(
      () => _i963.UserLoginAuthBloc(
        loginUseCase: gh<_i373.LoginUseCase>(),
        checkLoginStatusUseCase: gh<_i606.CheckLoginStatusUseCase>(),
      ),
    );
    gh.lazySingleton<_i944.WalletBloc>(
      () => _i944.WalletBloc(walletUseCase: gh<_i211.WalletUseCase>()),
    );
    return this;
  }
}
