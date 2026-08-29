import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Core/Theme/app_colors.dart';
import '../../Core/Spacing/app_space.dart';
import '../Home_Page/Presentation/Component/Charge_Internet_Page/Component/custom_header.dart';
import 'Domain/Repository/invoice_scanner_repository_Impl.dart';
import 'Presentation/Bloc/Invoice_Scanner_Bloc/invoice_scanner_bloc.dart';
import 'Presentation/Bloc/Invoice_Scanner_Bloc/invoice_scanner_event.dart';
import 'Presentation/Bloc/Invoice_Scanner_Bloc/invoice_scanner_state.dart';

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => InvoiceScannerBloc(
        repository: InvoiceScannerRepositoryImpl(),
      ),
      child: BlocListener<InvoiceScannerBloc, InvoiceScannerState>(
        listener: (context, state) {
          if (state is InvoiceScannerSuccess) {
            debugPrint('================================');
            debugPrint('Barcode: ${state.barcode}');
            debugPrint('================================');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'بارکد با موفقیت اسکن شد:\n${state.barcode}',
                ),
              ),
            );

            // TODO:
            // در این قسمت می‌توانیم درخواست استعلام قبض
            // را به API ارسال کنیم.
          }

          if (state is InvoiceScannerCancelled) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('اسکن بارکد لغو شد'),
              ),
            );
          }

          if (state is InvoiceScannerFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: theme.colorScheme.onPrimaryFixed,
          body: SafeArea(
            child: Column(
              children: [
                const CustomHeader(
                  title: 'پرداخت قبوض',
                  hasBackArrow: true,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نوع قبض را انتخاب کنید',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primaryFixed,
                          ),
                        ),

                        AppSpace.heightSpace_24,

                        GridView.builder(
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: billTypes.length,
                          itemBuilder: (context, index) {
                            final bill = billTypes[index];

                            return _buildBillItem(
                              context,
                              bill['title'] as String,
                              bill['icon'] as IconData,
                              bill['color'] as Color,
                            );
                          },
                        ),

                        AppSpace.heightSpace_32,

                        _buildBarcodeSection(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBillItem(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      ) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        // TODO:
        // منطق پرداخت قبض بر اساس نوع قبض
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withAlpha(15)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark
                ? Colors.white10
                : Colors.grey.shade100,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withAlpha(15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeSection(BuildContext context) {
    return BlocBuilder<InvoiceScannerBloc, InvoiceScannerState>(
      builder: (context, state) {
        final isLoading =
        state is InvoiceScannerLoading;

        return InkWell(
          onTap: isLoading
              ? null
              : () {
            context
                .read<InvoiceScannerBloc>()
                .add(
              ScanInvoiceBarcodeEvent(),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.splashGradiantColor1,
                  AppColors.splashGradiantColor2,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.splashGradiantColor1
                      .withAlpha(30),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'اسکن بارکد قبض',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        isLoading
                            ? 'در حال باز کردن دوربین...'
                            : 'برای پرداخت سریع‌تر، بارکد روی قبض را اسکن کنید',
                        style: TextStyle(
                          color: Colors.white.withAlpha(220),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: isLoading
                      ? const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static const List<Map<String, dynamic>> billTypes = [
    {
      'title': 'قبض آب',
      'icon': Icons.water_drop_rounded,
      'color': Colors.blue,
    },
    {
      'title': 'قبض برق',
      'icon': Icons.bolt_rounded,
      'color': Colors.amber,
    },
    {
      'title': 'قبض گاز',
      'icon': Icons.local_fire_department_rounded,
      'color': Colors.orange,
    },
    {
      'title': 'تلفن ثابت',
      'icon': Icons.phone_rounded,
      'color': Colors.teal,
    },
    {
      'title': 'تلفن همراه',
      'icon': Icons.phone_android_rounded,
      'color': Colors.purple,
    },
    {
      'title': 'جریمه رانندگی',
      'icon': Icons.directions_car_rounded,
      'color': Colors.red,
    },
    {
      'title': 'عوارض شهرداری',
      'icon': Icons.home_work_rounded,
      'color': Colors.brown,
    },
    {
      'title': 'مالیات',
      'icon': Icons.account_balance_wallet_rounded,
      'color': Colors.blueGrey,
    },
  ];
}