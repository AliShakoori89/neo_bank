import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../Core/Spacing/app_space.dart';
import '../../Core/Services/check_connection_service.dart';
import '../../Core/Widgets/custom_header.dart';
import '../Profile_Page/Presentation/Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_bloc.dart';
import '../Profile_Page/Presentation/Bloc/Citizen_EKYC_Status_Bloc/citizen_ekyc_status_event.dart';
import '../Profile_Page/Presentation/Component/authentication_status_dialog.dart';
import 'Presentation/Component/custom_icon_widget.dart';
import 'Presentation/Component/widget_container.dart';
import 'Presentation/Component/widget_title.dart';

class BankServicesPage extends StatefulWidget {
  const BankServicesPage({super.key});

  @override
  State<BankServicesPage> createState() => _BankServicesPageState();
}

class _BankServicesPageState extends State<BankServicesPage> {

  @override
  void initState() {
    checkConnection(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              navHeader(
                context,
                Text(
                  'خدمات بانکی',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                ),
              ),
        
              // --- Body ---
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widgetTitle(context, 'واریز و پرداخت'),
                    widgetContainer(context, [
                      InkWell(
                        onTap: (){
                          context.push('/fund_transfer_page');
                        },
                        child: CustomIconWidget(
                          iconPath:
                          'assets/svg/bank_services_page/switch-vertical.svg',
                          iconName: 'انتقال وجه',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          context.push('/charge_internet_page');
                        },
                        child: CustomIconWidget(
                          iconPath: 'assets/svg/bank_services_page/globe.svg',
                          iconName: 'اینترنت',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          context.push('/charge_internet_page');
                        },
                        child: CustomIconWidget(
                          iconPath: 'assets/svg/bank_services_page/simcard.svg',
                          iconName: 'شارژ',
                        ),
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/gift.svg',
                        iconName: 'تقویم مالی',
                      ),
                      InkWell(
                        onTap: (){
                          context.push('/invoices_page');
                        },
                        child: CustomIconWidget(
                          iconPath: 'assets/svg/bank_services_page/receipt.svg',
                          iconName: 'قبض',
                        ),
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/passcode.svg',
                        iconName: 'انتقال شناسه دار',
                      ),
                    ]),
        
                    AppSpace.heightSpace_4,
        
                    widgetTitle(context, 'امور حسابتان را آنلاین انجام دهید'),
                    widgetContainer(context, [
                      CustomIconWidget(
                        iconPath:
                        'assets/svg/bank_services_page/switch-vertical.svg',
                        iconName: 'افتتاح حساب جدید',
                      ),
                      CustomIconWidget(
                        iconPath:
                        'assets/svg/bank_services_page/credit-card.svg',
                        iconName: 'حساب و کارت',
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/calendar.svg',
                        iconName: 'تقویم مالی',
                      ),
                      CustomIconWidget(
                        iconPath:
                        'assets/svg/bank_services_page/credit-card-plus.svg',
                        iconName: 'صدور کارت',
                      ),
                      CustomIconWidget(
                        iconPath:
                        'assets/svg/bank_services_page/credit-card-x.svg',
                        iconName: 'مسدودی کارت',
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/passcode.svg',
                        iconName: 'تبدیل کارت به شبا',
                      ),
                    ]),
        
                    AppSpace.heightSpace_4,
        
                    widgetTitle(context, 'چک و وام خود را مدیریت کنید'),
                    widgetContainer(context, [
                      CustomIconWidget(
                        iconPath:
                        'assets/svg/bank_services_page/coins-hand.svg',
                        iconName: 'درخواست وام',
                      ),
                      InkWell(
                        onTap: (){
                          context.push('/loan_page');
                        },
                        child: CustomIconWidget(
                          iconPath: 'assets/svg/bank_services_page/wallet.svg',
                          iconName: 'وام من',
                        ),
                      ),
                      CustomIconWidget(
                        iconPath:
                        'assets/svg/bank_services_page/calculator.svg',
                        iconName: 'معدل حساب',
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/shuffle.svg',
                        iconName: 'انتقال امتیاز وام',
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/ticket.svg',
                        iconName: 'چک های من',
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/edit.svg',
                        iconName: 'چک صیادی',
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/passcode.svg',
                        iconName: 'اقساط دیگران',
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/passcode.svg',
                        iconName: 'اعتبار سنجی',
                      ),
                      InkWell(
                        onTap: (){
                          context.read<CitizenEkycStatusBloc>()
                              .add(FetchCitizenEkycStatusEvent());
                          authenticationStatusDialog(context, theme);
                        },
                        child: CustomIconWidget(
                          iconPath: 'assets/svg/authentication.svg',
                          iconName: 'احراز هویت',
                        ),
                      ),
                    ]),
        
                    AppSpace.heightSpace_4,
        
                    widgetTitle(context, 'با ما همراه باشید'),
                    widgetContainer(context, [
                      CustomIconWidget(
                        iconPath:
                        'assets/svg/bank_services_page/file-heart.svg',
                        iconName: 'همیارانر مهر',
                      ),
                      CustomIconWidget(
                        iconPath:
                        'assets/svg/bank_services_page/marker-pin.svg',
                        iconName: 'شعب بانک',
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/simcard.svg',
                        iconName: 'سجام',
                      ),
                      CustomIconWidget(
                        iconPath: 'assets/svg/bank_services_page/film.svg',
                        iconName: 'کلیپت',
                      ),
                      CustomIconWidget(
                        iconPath:
                        'assets/svg/bank_services_page/dots-horizontal.svg',
                        iconName: 'سایر خدمات',
                      ),
                    ]),
                  ],
                ),
              ),
        
              AppSpace.heightSpace_90,
            ],
          ),
        ),
      ),
    );
  }
}
