import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank_mehr_iran/Core/Routes/otp_args.dart';
import 'package:neo_bank_mehr_iran/Core/Routes/transaction_detail_args.dart';
import 'package:neo_bank_mehr_iran/Core/Routes/auth_gate.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/local_login_page.dart';
import 'package:neo_bank_mehr_iran/Features/Account_Page/Presentation/login_page.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Presentation/Component/ekyc_gate_page.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Presentation/ekyc_first_step_auth_page.dart';
import 'package:neo_bank_mehr_iran/Features/EKYC_Authentication_Page/Presentation/send_video_page.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Gift_Tab_Body/gift_details_page.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Gift_Tab_Body/message_and_amount_page.dart';
import 'package:neo_bank_mehr_iran/Features/Fund_Transfer_Page/Presentation/component/Gift_Tab_Body/send_gift_states_page.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Domain/Entities/loan_entity.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Charge_Internet_Page/charge_and_internet_page.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Loan_page/loan_page.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Component/Wallet_Page/wallet_page.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/Bloc/Request_OTP_Again/request_otp_again_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/OTP_Code_Page/Presentation/otp_code_page.dart';
import 'package:neo_bank_mehr_iran/Features/Profile_Page/Presentation/Component/about_application_page.dart';
import 'package:neo_bank_mehr_iran/Features/Set_Pass_Page/Presentation/set_pass_page.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/Component/transaction_detail_page.dart';
import 'package:neo_bank_mehr_iran/Features/Statement_Page/Presentation/statement_page.dart';
import 'package:neo_bank_mehr_iran/Features/Invoices_Page/Presentation/Component/invoice_details.dart';
import '../../Features/AI_Assistant/Presentation/Pages/ai_assistant_page.dart';
import '../../Features/Fund_Transfer_Page/Presentation/component/Gift_Tab_Body/select_design_page.dart';
import '../../Features/Fund_Transfer_Page/Presentation/fund_transfer_page.dart';
import '../../Features/Fund_Transfer_Page/Presentation/fund_transfer_tab.dart';
import '../../Features/Home_Page/Data/Model/internet_package_model.dart';
import '../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/Package_Card_Component/Package_Details/package_details.dart';
import '../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Directive_Charge/directive_charge_page.dart';
import '../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Internet_package/internet_packages_page.dart';
import '../../Features/Home_Page/Presentation/Component/Charge_Internet_Page/Component/Payment_Page/Component/Payment_Page/payment_page.dart';
import '../../Features/Home_Page/Presentation/Component/Loan_page/Component/installment_item_details.dart';
import '../../Features/Invoices_Page/invoices_page.dart';
import '../../Features/Main_Page/Presentation/main_page.dart';
import '../../Features/OTP_Code_Page/Data/DataSources/Request_otp_code_again_remote_data_source.dart';
import '../../Features/OTP_Code_Page/Data/Repositories/request_otp_code_again_repository_impl.dart';
import '../../Features/OTP_Code_Page/Domain/UseCases/request_otp_code_again_use_case.dart';
import '../Network/dio_client.dart';
import '../Services/App_Lock/navigator_key.dart';

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

        final dioClient  = DioClient();

        final remoteDataSource = RequestOtpCodeAgainRemoteDataSource( dioClient: dioClient, );

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
      builder: (context, state) {
        final initialTab = state.extra as FundTransferTab? ?? FundTransferTab.card;

        return FundTransferPage(
          initialTab: initialTab,
        );
      },
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

    GoRoute(
      path: '/send_gift_states_page',
      builder: (context, state) {
        final extra = state.extra as Map?;
        return SendGiftStatesPage(
          phoneNumber: extra?['phoneNumber'],
        );
      },
    ),

    GoRoute(
      path: '/select_design_page',
      builder: (context, state) {
        final extra = state.extra as Map?;
        return SelectDesignPage(
          phoneNumber: extra?['phoneNumber'],
        );
      },
    ),

    GoRoute(
      path: '/message_and_amount_page',
      builder: (context, state) {
        final extra = state.extra as Map?;
        return MessageAndAmountPage(
          phoneNumber: extra?['phoneNumber'],
          imgPath: extra?['imgPath'],
          cardTitle: extra?['cardTitle'],
        );
      },
    ),

    GoRoute(
      path: '/invoice_details',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return InvoiceDetails(
          title: extra?['title'] ?? 'جزئیات قبض',
          icon: extra?['icon'] as IconData?,
          color: extra?['color'] as Color?,
        );
      },
    ),

    GoRoute(
      path: '/gift_details_page',
      builder: (context, state) {
        final extra = state.extra as Map?;
        return GiftDetailsPage(
          phoneNumber: extra?['phoneNumber'],
          imgPath: extra?['imgPath'],
          cardTitle: extra?['cardTitle'],
          amount: extra?['amount'],
          message: extra?['message'],
        );
      },
    ),

    GoRoute(
      path: '/ai_assistant_page',
      builder: (context, state) {
        return AiAssistantPage();
      },
    ),
  ],
);
