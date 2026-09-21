// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:neo_bank_mehr_iran/Core/DI/register_module.dart' as _i390;
import 'package:neo_bank_mehr_iran/Core/GenUI/Actions/ui_action_handler.dart'
    as _i979;
import 'package:neo_bank_mehr_iran/Core/GenUI/Actions/ui_action_registry.dart'
    as _i943;
import 'package:neo_bank_mehr_iran/Core/GenUI/State/ui_state_registry.dart'
    as _i891;
import 'package:neo_bank_mehr_iran/Core/GenUI/Validation/ui_schema_validator.dart'
    as _i978;
import 'package:neo_bank_mehr_iran/Core/Network/dio_client.dart' as _i893;
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Data_Sources/auth_remote_data_source.dart'
    as _i412;
import 'package:neo_bank_mehr_iran/Features/Account_Page/Data/Repositories/user_login_auth_repository_impl.dart'
    as _i513;
import 'package:neo_bank_mehr_iran/Features/Account_Page/Domain/Repositories/user_login_auth_repository.dart'
    as _i366;
import 'package:neo_bank_mehr_iran/Features/Account_Page/Domain/UseCases/check_login_status_use_case.dart'
    as _i394;
import 'package:neo_bank_mehr_iran/Features/Account_Page/Domain/UseCases/login_use_case.dart'
    as _i480;
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/Bloc/User_Login_Auth/user_login_auth_bloc.dart'
    as _i757;
import 'package:neo_bank_mehr_iran/Features/AI_Assistant/Data/DataSources/ai_schema_data_source.dart'
    as _i612;
import 'package:neo_bank_mehr_iran/Features/AI_Assistant/Data/DataSources/gemini_schema_data_source.dart'
    as _i994;
import 'package:neo_bank_mehr_iran/Features/AI_Assistant/Data/Repositories/ai_schema_repository_impl.dart'
    as _i258;
import 'package:neo_bank_mehr_iran/Features/AI_Assistant/Domain/Repositories/ai_schema_repository.dart'
    as _i430;
import 'package:neo_bank_mehr_iran/Features/AI_Assistant/Domain/UseCases/generate_ui_schema_use_case.dart'
    as _i216;
import 'package:neo_bank_mehr_iran/Features/AI_Assistant/Domain/UseCases/get_balance_use_case.dart'
    as _i324;
import 'package:neo_bank_mehr_iran/Features/AI_Assistant/Presentation/Actions/ai_assistant_action_registry.dart'
    as _i724;
import 'package:neo_bank_mehr_iran/Features/AI_Assistant/Presentation/Bloc/Account_Bloc/account_bloc.dart'
    as _i671;
import 'package:neo_bank_mehr_iran/Features/AI_Assistant/Presentation/Bloc/AI_Assistant_Bloc/ai_assistant_bloc.dart'
    as _i639;
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/DataSources/all_card_detail_remote_data_source.dart'
    as _i444;
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/DataSources/deposit_remote_data_source.dart'
    as _i874;
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/Repositories/all_card_detail_repository_impl.dart'
    as _i348;
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Data/Repositories/deposits_repository_impl.dart'
    as _i651;
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repositories/all_card_detail_repository.dart'
    as _i362;
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/Repositories/deposits_repository.dart'
    as _i25;
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/UseCases/all_card_detail_use_case.dart'
    as _i477;
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Domain/UseCases/deposit_use_case.dart'
    as _i173;
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Account_Tab_Bloc/user_all_account_bloc.dart'
    as _i85;
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/Bloc/Cart_Tab_Bloc/all_cards_detail_bloc.dart'
    as _i866;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Data_Sources/all_card_data_source.dart'
    as _i109;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Data_Sources/internet_packages_data_sources.dart'
    as _i424;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Data_Sources/loan_page_data_source.dart'
    as _i572;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Data_Sources/transaction_data_source.dart'
    as _i300;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Data_Sources/wallet_data_source.dart'
    as _i914;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Repositories/all_card_repository_impl.dart'
    as _i9;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Repositories/internet_package_repository_impl.dart'
    as _i771;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Repositories/loan_page_repository_impl.dart'
    as _i24;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Repositories/transaction_repository_impl.dart'
    as _i458;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Data/Repositories/wallet_repository_impl.dart'
    as _i230;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repositories/all_card_repository.dart'
    as _i234;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repositories/internet_packages_repository.dart'
    as _i99;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repositories/loan_page_repository.dart'
    as _i517;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repositories/transaction_repository.dart'
    as _i892;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Repositories/wallet_repository.dart'
    as _i983;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/UseCases/all_cards_use_case.dart'
    as _i829;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/UseCases/internet_package_use_case.dart'
    as _i917;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/UseCases/loan_page_use_case.dart'
    as _i56;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/UseCases/transaction_use_case.dart'
    as _i37;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/UseCases/wallet_use_case.dart'
    as _i22;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/All_cards_Bloc/all_cards_bloc.dart'
    as _i54;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart'
    as _i894;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Loan_Page_Bloc/loan_page_bloc.dart'
    as _i840;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Transaction_Bloc/transaction_bloc.dart'
    as _i553;
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Wallet_Bloc/wallet_bloc.dart'
    as _i172;
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/DataSources/otp_code_check_remote_data_source.dart'
    as _i78;
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/DataSources/Request_otp_code_again_remote_data_source.dart'
    as _i941;
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/Repositories/otp_code_check_repository_impl.dart'
    as _i79;
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Data/Repositories/request_otp_code_again_repository_impl.dart'
    as _i233;
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repositories/otp_code_check_repository.dart'
    as _i34;
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/Repositories/request_otp_code_again_repository.dart'
    as _i468;
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/UseCases/otp_code_check_use_case.dart'
    as _i867;
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Domain/UseCases/request_otp_code_again_use_case.dart'
    as _i367;
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/OTP_Code_Check/otp_code_check_bloc.dart'
    as _i747;
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Data/Data_Sources/citizen_ekyc_status_remote_data_source.dart'
    as _i64;
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Data/Repositories/citizen_ekyc_status_repository_impl.dart'
    as _i985;
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Domain/Repositories/citizen_kyc_status_repository.dart'
    as _i1038;
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Domain/UseCases/citizen_ekyc_status_use_case.dart'
    as _i286;
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_bloc.dart'
    as _i456;
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Data/Data_Sources/statement_data_sources.dart'
    as _i5;
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Data/Repositories/statement_repository_impl.dart'
    as _i716;
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Domain/Repositories/statement_repository.dart'
    as _i150;
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Domain/UseCases/fetch_statement_filtered_use_case.dart'
    as _i749;
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Domain/UseCases/fetch_statement_use_case.dart'
    as _i849;
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Bloc/Statement_Bloc/statement_bloc.dart'
    as _i982;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i943.UiActionRegistry>(() => _i943.UiActionRegistry());
    gh.lazySingleton<_i891.UiStateRegistry>(() => _i891.UiStateRegistry());
    gh.lazySingleton<_i893.DioClient>(() => _i893.DioClient());
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.geminiDio,
      instanceName: 'geminiDio',
    );
    gh.lazySingleton<_i412.AuthRemoteDataSource>(
      () => _i412.AuthRemoteDataSource(dioClient: gh<_i893.DioClient>()),
    );
    gh.lazySingleton<_i444.AllCardDetailRemoteDataSource>(
      () =>
          _i444.AllCardDetailRemoteDataSource(dioClient: gh<_i893.DioClient>()),
    );
    gh.lazySingleton<_i874.DepositRemoteDataSource>(
      () => _i874.DepositRemoteDataSource(dioClient: gh<_i893.DioClient>()),
    );
    gh.lazySingleton<_i109.AllCardDataSource>(
      () => _i109.AllCardDataSource(dioClient: gh<_i893.DioClient>()),
    );
    gh.lazySingleton<_i424.InternetPackagesDataSources>(
      () => _i424.InternetPackagesDataSources(dioClient: gh<_i893.DioClient>()),
    );
    gh.lazySingleton<_i572.LoanPageDataSource>(
      () => _i572.LoanPageDataSource(dioClient: gh<_i893.DioClient>()),
    );
    gh.lazySingleton<_i300.TransactionDataSource>(
      () => _i300.TransactionDataSource(dioClient: gh<_i893.DioClient>()),
    );
    gh.lazySingleton<_i914.WalletDataSource>(
      () => _i914.WalletDataSource(dioClient: gh<_i893.DioClient>()),
    );
    gh.lazySingleton<_i941.RequestOtpCodeAgainRemoteDataSource>(
      () => _i941.RequestOtpCodeAgainRemoteDataSource(
        dioClient: gh<_i893.DioClient>(),
      ),
    );
    gh.lazySingleton<_i78.OtpCodeCheckRemoteDataSource>(
      () => _i78.OtpCodeCheckRemoteDataSource(dioClient: gh<_i893.DioClient>()),
    );
    gh.lazySingleton<_i64.CitizenEkycStatusRemoteDataSource>(
      () => _i64.CitizenEkycStatusRemoteDataSource(
        dioClient: gh<_i893.DioClient>(),
      ),
    );
    gh.lazySingleton<_i5.StatementDataSources>(
      () => _i5.StatementDataSources(dioClient: gh<_i893.DioClient>()),
    );
    gh.lazySingleton<_i517.LoanPageRepository>(
      () => _i24.LoanPageRepositoryImpl(
        loanPageDataSource: gh<_i572.LoanPageDataSource>(),
      ),
    );
    gh.lazySingleton<_i978.UiSchemaValidator>(
      () => _i978.UiSchemaValidator(
        actionRegistry: gh<_i943.UiActionRegistry>(),
        stateRegistry: gh<_i891.UiStateRegistry>(),
      ),
    );
    gh.lazySingleton<_i468.RequestOtpCodeAgainRepository>(
      () => _i233.RequestOtpCodeAgainRepositoryImpl(
        requestOtpCodeAgainRemoteDataSource:
            gh<_i941.RequestOtpCodeAgainRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i983.WalletRepository>(
      () => _i230.WalletRepositoryImpl(
        walletDataSource: gh<_i914.WalletDataSource>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.openAiDio,
      instanceName: 'openAiDio',
    );
    gh.lazySingleton<_i612.AiSchemaDataSource>(
      () => _i994.GeminiSchemaDataSource(
        dio: gh<_i361.Dio>(instanceName: 'geminiDio'),
      ),
    );
    gh.lazySingleton<_i892.TransactionRepository>(
      () => _i458.TransactionRepositoryImpl(
        transactionDataSource: gh<_i300.TransactionDataSource>(),
      ),
    );
    gh.lazySingleton<_i56.LoanPageUseCase>(
      () => _i56.LoanPageUseCase(
        loanPageRepository: gh<_i517.LoanPageRepository>(),
      ),
    );
    gh.lazySingleton<_i34.OtpCodeCheckRepository>(
      () => _i79.OtpCodeCheckRepositoryImpl(
        otpCodeCheckRemoteDataSource: gh<_i78.OtpCodeCheckRemoteDataSource>(),
      ),
    );
    gh.factory<_i840.LoanPageBloc>(
      () => _i840.LoanPageBloc(loanPageUseCase: gh<_i56.LoanPageUseCase>()),
    );
    gh.lazySingleton<_i22.WalletUseCase>(
      () => _i22.WalletUseCase(walletRepository: gh<_i983.WalletRepository>()),
    );
    gh.lazySingleton<_i234.AllCardRepository>(
      () => _i9.AllCardRepositoryImpl(
        allCardDataSources: gh<_i109.AllCardDataSource>(),
      ),
    );
    gh.lazySingleton<_i99.InternetPackagesRepository>(
      () => _i771.InternetPackageRepositoryImpl(
        internetPackagesDataSources: gh<_i424.InternetPackagesDataSources>(),
      ),
    );
    gh.lazySingleton<_i366.UserLoginAuthRepository>(
      () => _i513.UserLoginAuthRepositoryImpl(
        remoteDataSource: gh<_i412.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i430.AiSchemaRepository>(
      () => _i258.AiSchemaRepositoryImpl(
        dataSource: gh<_i612.AiSchemaDataSource>(),
      ),
    );
    gh.lazySingleton<_i367.RequestOtpCodeAgainUseCase>(
      () => _i367.RequestOtpCodeAgainUseCase(
        repository: gh<_i468.RequestOtpCodeAgainRepository>(),
      ),
    );
    gh.lazySingleton<_i150.StatementRepository>(
      () => _i716.StatementRepositoryImpl(
        statementDataSources: gh<_i5.StatementDataSources>(),
      ),
    );
    gh.lazySingleton<_i362.AllCardDetailRepository>(
      () => _i348.AllCardDetailRepositoryImpl(
        allCardDetailRemoteDataSource:
            gh<_i444.AllCardDetailRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i979.UiActionHandler>(
      () => _i979.UiActionHandler(registry: gh<_i943.UiActionRegistry>()),
    );
    gh.lazySingleton<_i25.DepositsRepository>(
      () => _i651.DepositsRepositoryImpl(
        depositRemoteDataSource: gh<_i874.DepositRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i749.FetchStatementFilteredUseCase>(
      () => _i749.FetchStatementFilteredUseCase(
        repository: gh<_i150.StatementRepository>(),
      ),
    );
    gh.lazySingleton<_i849.FetchStatementUseCase>(
      () => _i849.FetchStatementUseCase(
        repository: gh<_i150.StatementRepository>(),
      ),
    );
    gh.lazySingleton<_i1038.GetCitizenEKYCStatusRepository>(
      () => _i985.CitizenEkycStatusRepositoryImpl(
        citizenEkycStatusRemoteDataSource:
            gh<_i64.CitizenEkycStatusRemoteDataSource>(),
      ),
    );
    gh.factory<_i172.WalletBloc>(
      () => _i172.WalletBloc(walletUseCase: gh<_i22.WalletUseCase>()),
    );
    gh.lazySingleton<_i867.OtpCodeCheckUseCase>(
      () => _i867.OtpCodeCheckUseCase(
        repository: gh<_i34.OtpCodeCheckRepository>(),
      ),
    );
    gh.lazySingleton<_i37.TransactionUseCase>(
      () => _i37.TransactionUseCase(
        transactionRepository: gh<_i892.TransactionRepository>(),
      ),
    );
    gh.lazySingleton<_i917.InternetPackageUseCase>(
      () => _i917.InternetPackageUseCase(
        repository: gh<_i99.InternetPackagesRepository>(),
      ),
    );
    gh.factory<_i894.InternetPackageBloc>(
      () => _i894.InternetPackageBloc(
        internetPackageUseCase: gh<_i917.InternetPackageUseCase>(),
      ),
    );
    gh.lazySingleton<_i829.AllCardsUseCase>(
      () => _i829.AllCardsUseCase(
        allCardRepository: gh<_i234.AllCardRepository>(),
      ),
    );
    gh.lazySingleton<_i173.DepositUseCase>(
      () => _i173.DepositUseCase(repository: gh<_i25.DepositsRepository>()),
    );
    gh.factory<_i982.StatementBloc>(
      () => _i982.StatementBloc(
        gh<_i749.FetchStatementFilteredUseCase>(),
        gh<_i849.FetchStatementUseCase>(),
      ),
    );
    gh.lazySingleton<_i477.AllCardDetailUseCase>(
      () => _i477.AllCardDetailUseCase(
        repository: gh<_i362.AllCardDetailRepository>(),
      ),
    );
    gh.lazySingleton<_i394.CheckLoginStatusUseCase>(
      () => _i394.CheckLoginStatusUseCase(
        repository: gh<_i366.UserLoginAuthRepository>(),
      ),
    );
    gh.lazySingleton<_i480.LoginUseCase>(
      () => _i480.LoginUseCase(repository: gh<_i366.UserLoginAuthRepository>()),
    );
    gh.factory<_i216.GenerateUiSchemaUseCase>(
      () => _i216.GenerateUiSchemaUseCase(
        repository: gh<_i430.AiSchemaRepository>(),
      ),
    );
    gh.lazySingleton<_i286.CitizenEkycStatusUseCase>(
      () => _i286.CitizenEkycStatusUseCase(
        repository: gh<_i1038.GetCitizenEKYCStatusRepository>(),
      ),
    );
    gh.factory<_i639.AiAssistantBloc>(
      () => _i639.AiAssistantBloc(
        generateUiSchemaUseCase: gh<_i216.GenerateUiSchemaUseCase>(),
        validator: gh<_i978.UiSchemaValidator>(),
      ),
    );
    gh.factory<_i85.UserAllAccountBloc>(
      () => _i85.UserAllAccountBloc(depositUseCase: gh<_i173.DepositUseCase>()),
    );
    gh.factory<_i553.TransactionBloc>(
      () => _i553.TransactionBloc(
        transactionUseCase: gh<_i37.TransactionUseCase>(),
      ),
    );
    gh.factory<_i757.UserLoginAuthBloc>(
      () => _i757.UserLoginAuthBloc(
        loginUseCase: gh<_i480.LoginUseCase>(),
        checkLoginStatusUseCase: gh<_i394.CheckLoginStatusUseCase>(),
      ),
    );
    gh.lazySingleton<_i747.OtpCodeCheckBloc>(
      () => _i747.OtpCodeCheckBloc(
        otpCodeCheckUseCase: gh<_i867.OtpCodeCheckUseCase>(),
      ),
    );
    gh.factory<_i324.GetBalanceUseCase>(
      () =>
          _i324.GetBalanceUseCase(allCardsUseCase: gh<_i829.AllCardsUseCase>()),
    );
    gh.factory<_i54.AllCardsBloc>(
      () => _i54.AllCardsBloc(allCardsUseCase: gh<_i829.AllCardsUseCase>()),
    );
    gh.factory<_i456.CitizenEkycStatusBloc>(
      () => _i456.CitizenEkycStatusBloc(
        citizenEkycStatusUseCase: gh<_i286.CitizenEkycStatusUseCase>(),
      ),
    );
    gh.factory<_i866.AllCardsDetailBloc>(
      () => _i866.AllCardsDetailBloc(
        allCardDetailUseCase: gh<_i477.AllCardDetailUseCase>(),
      ),
    );
    gh.factory<_i671.AccountBloc>(
      () => _i671.AccountBloc(getBalanceUseCase: gh<_i324.GetBalanceUseCase>()),
    );
    gh.lazySingleton<_i724.AiAssistantActionRegistry>(
      () => _i724.AiAssistantActionRegistry(
        registry: gh<_i943.UiActionRegistry>(),
        accountBloc: gh<_i671.AccountBloc>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i390.RegisterModule {}
