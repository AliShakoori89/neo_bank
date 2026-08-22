import 'package:flutter/material.dart';
import '../../../../../Core/Const/app_colors.dart';
import '../../../../../Core/Const/app_space.dart';
import '../Charge_Internet_Page/Component/custom_header.dart';

class InvoicesPage extends StatelessWidget {
  const InvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> billTypes = [
      {'title': 'قبض آب', 'icon': Icons.water_drop_rounded, 'color': Colors.blue},
      {'title': 'قبض برق', 'icon': Icons.bolt_rounded, 'color': Colors.amber},
      {'title': 'قبض گاز', 'icon': Icons.local_fire_department_rounded, 'color': Colors.orange},
      {'title': 'تلفن ثابت', 'icon': Icons.phone_rounded, 'color': Colors.teal},
      {'title': 'تلفن همراه', 'icon': Icons.phone_android_rounded, 'color': Colors.purple},
      {'title': 'جریمه رانندگی', 'icon': Icons.directions_car_rounded, 'color': Colors.red},
      {'title': 'عوارض شهرداری', 'icon': Icons.home_work_rounded, 'color': Colors.brown},
      {'title': 'مالیات', 'icon': Icons.account_balance_wallet_rounded, 'color': Colors.blueGrey},
    ];

    return Scaffold(
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
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          bill['title'],
                          bill['icon'],
                          bill['color'],
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
    );
  }

  Widget _buildBillItem(BuildContext context, String title, IconData icon, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        // TODO: Implement bill payment logic
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.grey.shade100,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
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
            color: AppColors.splashGradiantColor1.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'برای پرداخت سریع‌تر، بارکد روی قبض را اسکن کنید',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
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
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
