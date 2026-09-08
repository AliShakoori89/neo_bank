import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank/Core/Routes/transaction_detail_args.dart';
import '../../Features/Account_Page/Presentation/local_login_page.dart';
import '../../Features/Account_Page/Presentation/login_page.dart';
import '../../Features/EKYC_Authentication_Page/Presentation/Component/ekyc_gate_page.dart';
import '../../Features/EKYC_Authentication_Page/Presentation/ekyc_first_step_auth_page.dart';
import '../../Features/EKYC_Authentication_Page/Presentation/send_video_page.dart';
import '../../Features/Fund_Transfer_Page/Presentation/fund_transfer_page.dart';
import '../../Features/Home_Page/Data/Model/internet_package_model.dart';
import '../../Features/Home_Page/Domain/Entities/loan_entity.dart';
import '../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/Package_Details/package_details.dart';
import '../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Directive_Charge/directive_charge_page.dart';
import '../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/internet_packages_page.dart';
import '../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Payment_Page/Component/Payment_Page/payment_page.dart';
import '../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/charge_and_internet_page.dart';
import '../../Features/Home_Page/Presentation/Component/Loan_page/Component/installment_item_details.dart';
import '../../Features/Home_Page/Presentation/Component/Loan_page/loan_page.dart';
import '../../Features/Home_Page/Presentation/Component/Wallet_Page/wallet_page.dart';
import '../../Features/Invoices_Page/invoices_page.dart';
import '../../Features/Main_Page/Presentation/main_page.dart';
import '../../Features/OTP_Code_Page/Data/DataSources/Request_otp_code_again_remote_data_source.dart';
import '../../Features/OTP_Code_Page/Data/Repositories/request_otp_code_again_repository_impl.dart';
import '../../Features/OTP_Code_Page/Domain/UseCases/request_otp_code_again_use_case.dart';
import '../../Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/request_otp_again_bloc.dart';
import '../../Features/OTP_Code_Page/Presentation/otp_code_page.dart';
import '../../Features/Profile_Page/Presentation/Component/about_application_page.dart';
import '../../Features/Set_Pass_Page/Presentation/set_pass_page.dart';
import '../../Features/Statement_Page/Presentation/Component/transaction_detail_page.dart';
import '../../Features/Statement_Page/Presentation/statement_page.dart';
import '../Network/dio_client.dart';
import '../Services/App_Lock/navigator_key.dart';
import 'auth_gate.dart';
import 'otp_args.dart';

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [

    GoRoute(path: '/', builder: (context, state) => const AuthGate()),

    GoRoute(
      path: '/main_page',
      builder: (context, state) {
        final index = state.extra as int? ?? 0;

        return MainPage(initialIndex: index);
      },
    ),

    GoRoute(
      path: '/otp_code_page',
      builder: (context, state) {
        final args = state.extra as OtpArgs;

        final dio = DioClient().dio;

        final remoteDataSource = RequestOtpCodeAgainRemoteDataSource( dio: dio, );

        final repository = RequestOtpCodeAgainRepositoryImpl( requestOtpCodeAgainRemoteDataSource: remoteDataSource, );

        final useCase = RequestOtpCodeAgainUseCase( repository: repository, );

        return BlocProvider(
          create: (_) =>
              RequestOtpAgainBloc(requestOtpCodeAgainUseCase: useCase,),
          child: OtpCodePage(
            phoneNumber: args.phoneNumber,
            nationalCode: args.nationalCode,
            deviceId: args.deviceId,
            secretKey: args.secretKey,
            expireTime: args.expireTime,
          ),
        );
      },
    ),

    GoRoute(
      path: '/login_page',
      builder: (context, state) {
        return LoginPage();
      },
    ),

    GoRoute(
      path: '/set_pass_page',
      builder: (context, state) {
        final bool? inputFromProfile = state.extra as bool?;
        return SetPassPage(inputFromProfile: inputFromProfile);
      },
    ),

    GoRoute(
      path: '/local_login_page',
      builder: (context, state) => const LocalLoginPage(),
    ),

    GoRoute(
      path: '/fund_transfer_page',
      builder: (context, state) => const FundTransferPage(),
    ),

    GoRoute(
      path: '/loan_page',
      builder: (context, state) => const LoanPage(),
    ),

    GoRoute(
      path: '/invoices_page',
      builder: (context, state) => const InvoicesPage(),
    ),

    GoRoute(
      path: '/installment_item_details',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        return InstallmentItemDetails(
          loanNumber: extra['loanNumber'] as String,
          installment: extra['installment'] as InstallmentEntity,
        );
      },
    ),

    GoRoute(
      path: '/payment_page',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return PaymentPage(
          amount: extra?['amount'] ?? '0',
          title: extra?['title'] ?? 'پرداخت',
          package: extra?['package'] as InternetPackage?,
          phoneNumber: extra?['phoneNumber'] as String?,
        );
      },
    ),

    GoRoute(
      path: '/statement_page',
      builder: (context, state) => const StatementPage(),
    ),

    GoRoute(
      path: '/transaction_detail_page',
      builder: (context, state) {
        final args = state.extra as TransactionDetailArgs;

        return TransactionDetailPage(
          date: args.date,
          title: args.title,
          transferAmount: args.transferAmount,
          description: args.description,
        );
      },
    ),

    GoRoute(
      path: '/charge_internet_page',
      builder: (context, state) => const ChargeAndInternetPage(),
    ),

    GoRoute(
      path: '/directive_charge_page',
      builder: (context, state) => DirectiveChargePage(),
    ),

    GoRoute(
      path: '/wallet_page',
      builder: (context, state) => WalletPage(),
    ),

    // در فایل router.dart
    GoRoute(
      path: '/internet_package_details_page',
      name: 'internet_package_details_page',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return InternetPackageDetailsPage(
          package: extra['package'] as InternetPackage,
          phoneNumber: extra['phoneNumber'] as String,
          operatorCode: extra['operatorCode'] as int,
        );
      },
    ),

    GoRoute(
      path: '/internet_package_page',
      builder: (context, state) {
        final extra = state.extra as Map?;
        return InternetPackagesPage(
          selectedOperator: extra?['selectedOperator'],
          selectedSimType: extra?['selectedSimType'],
          phoneNumber: extra?['phoneNumber'],
        );
      },
    ),

    GoRoute(
      path: '/ekyc_first_step_auth_page',
      builder: (context, state) {
        return EkycFirstStepAuthPage();
      },
    ),

    GoRoute(
      path: '/send_video_page',
      builder: (context, state) {
        final extra = state.extra as Map?;
        return SendVideoPage(
          data: extra?['data'],
        );
      },
    ),

    GoRoute(
      path: '/ekyc_gate_page',
      builder: (context, state) {
        return EkycGatePage();
      },
    ),

    GoRoute(
      path: '/about_application_page',
      builder: (context, state) {
        return AboutApplicationPage();
      },
    ),
  ],
);
