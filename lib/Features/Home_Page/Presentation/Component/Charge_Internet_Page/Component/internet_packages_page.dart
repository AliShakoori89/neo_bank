import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';
import 'package:neo_bank_mehr_iran/Core/Utils/error_refresh_widget.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Get_Internet_Packages_Bloc/get_internet_packages_bloc.dart';
import 'package:neo_bank_mehr_iran/Features/Home_Page/Presentation/Bloc/Get_Internet_Packages_Bloc/get_internet_packages_state.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../../../../../Core/Const/app_colors.dart';
import '../../../../Data/Model/internet_package_model.dart';
import '../../../Bloc/Get_Internet_Packages_Bloc/get_internet_packages_event.dart';
import 'custom_header.dart';
import 'internet_package_time_box.dart';


class InternetPackagesPage extends StatefulWidget {
  const InternetPackagesPage({super.key, required this.selectedOperator, required this.selectedSimType, required this.phoneNumber});

  final int selectedOperator;
  final int selectedSimType;
  final String phoneNumber;

  @override
  State<InternetPackagesPage> createState() => _InternetPackagesPageState();
}

class _InternetPackagesPageState extends State<InternetPackagesPage> {

  int _getPackageTimeCode(String packageType) {
    switch (packageType) {
      case 'روزانه':
        return 1; // یا هر کدی که API شما نیاز دارد
      case 'شبانه':
        return 2;
      case 'ترکیبی':
        return 3;
      case 'مناسبتی':
        return 4;
      default:
        return 2;
    }
  }
  String selectedPackageType = 'همه';

  void _fetchPackages(String packageType) {
    int packageTimeCode = _getPackageTimeCode(packageType);

    BlocProvider.of<InternetPackageBloc>(context).add(FetchInternetPackages(
        operatorCode: widget.selectedOperator,
        packageTimeCode: packageTimeCode,
        simType: widget.selectedSimType,
        traffic: '500'
    ));
  }

  void _fetchAllPackages(String packageType) {

    int packageTimeCode = _getPackageTimeCode(packageType);

    BlocProvider.of<InternetPackageBloc>(context).add(FetchAllInternetPackages(
        operatorCode: packageTimeCode,
    ));
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryFixed,
        body: Column(
          children: [
            CustomHeader(title: 'انتخاب بسته اینترنت'),
            AppSpace.heightSpace_12,
            Row(
              children: [
                InternetPackageTimeBox(
                  title: 'همه',
                  isSelected: selectedPackageType == 'همه',
                  onTap: () {
                    setState(() {
                      selectedPackageType = 'همه';
                    });
                    _fetchAllPackages('همه');
                  },
                ),
                InternetPackageTimeBox(
                  title: 'روزانه',
                  isSelected: selectedPackageType == 'روزانه',
                  onTap: () {
                    setState(() {
                      selectedPackageType = 'روزانه';
                    });
                    _fetchPackages('روزانه');
                  },
                ),
                InternetPackageTimeBox(
                  title: 'شبانه',
                  isSelected: selectedPackageType == 'شبانه',
                  onTap: () {
                    setState(() {
                      selectedPackageType = 'شبانه';
                    });
                    _fetchPackages('شبانه');
                  },
                ),
                InternetPackageTimeBox(
                  title: 'ترکیبی',
                  isSelected: selectedPackageType == 'ترکیبی',
                  onTap: () {
                    setState(() {
                      selectedPackageType = 'ترکیبی';
                    });
                    _fetchPackages('ترکیبی');
                  },
                ),
                InternetPackageTimeBox(
                  title: 'مناسبتی',
                  isSelected: selectedPackageType == 'مناسبتی',
                  onTap: () {
                    setState(() {
                      selectedPackageType = 'مناسبتی';
                    });
                    _fetchPackages('مناسبتی');
                  },
                ),
              ],
            ),
            AppSpace.heightSpace_12,
            BlocBuilder<InternetPackageBloc, InternetPackageState>(
              builder: (context, state){
                if(state.status.isLoading){
                  return CircularProgressIndicator();
                }else if(state.status.isSuccess){
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.internetPackages!.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final package = state.internetPackages![index];
                        return _buildPackageCard(context, package, index);
                      },
                    ),
                  );
                }else if(state.status.isError){
                  return ErrorRefreshWidget(refreshFunction: (){
                    _fetchAllPackages(widget.selectedOperator.toString());
                  });
                }
                return ErrorRefreshWidget(refreshFunction: (){
                  _fetchAllPackages(widget.selectedOperator.toString());
                });
              },
            )

          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context, InternetPackageModel package, int index) {
    final theme = Theme.of(context);

    // استخراج اطلاعات از package
    String? packageTime = package.packageTime;
    String rawTraffic = package.traffic ?? '0';  // مقدار خام
    String? rawNightTraffic = package.nightTraffic?.toString();
    String duration = package.duration ?? '';
    String price = _formatPrice(package.price);
    String priceWithTax = _formatPrice(package.priceWithTax);
    String description = package.description ?? '';

    // فرمت کردن برای نمایش
    String formattedTraffic = _formatTraffic(rawTraffic);
    String? formattedNightTraffic = rawNightTraffic != null ? _formatTraffic(rawNightTraffic) : null;

    // تعیین رنگ براساس نوع بسته
    Color getPackageColor() {
      switch (packageTime) {
        case 'روزانه':
          return Colors.orange;
        case 'شبانه':
          return Colors.indigo;
        case 'ترکیبی':
          return Colors.purple;
        case 'مناسبتی':
          return Colors.red;
        default:
          return Colors.teal;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color:  theme.cardColor.withAlpha(10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // هدر: نوع بسته و قیمت
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // آیکون و نوع بسته
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.darkModeIconIconColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        _getPackageIcon(packageTime!),
                        color: getPackageColor(),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            packageTime,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // قیمت
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${price.toPersianDigit()} تومان',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.splashGradiantColor2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${priceWithTax.toPersianDigit()} تومان',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildInfoChip(
                      icon: Icons.data_usage,
                      label: formattedTraffic,  // استفاده از مقدار فرمت شده
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      icon: Icons.access_time,
                      label: '$duration روزه',
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                    if (formattedNightTraffic != null) ...[
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        icon: Icons.nightlight_round,
                        label: 'شبانه: $formattedNightTraffic',
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primaryFixed,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPackageIcon(String packageTime) {
    switch (packageTime) {
      case 'روزانه':
        return Icons.wb_sunny;
      case 'شبانه':
        return Icons.nightlight_round;
      case 'ترکیبی':
        return Icons.compare_arrows;
      case 'مناسبتی':
        return Icons.celebration;
      default:
        return Icons.wifi;
    }
  }

  String _formatTraffic(dynamic traffic) {
    int trafficInt;

    if (traffic is int) {
      trafficInt = traffic;
    } else if (traffic is String) {
      trafficInt = int.tryParse(traffic) ?? 0;
    } else {
      trafficInt = 0;
    }

    if (trafficInt >= 1024) {
      double gb = trafficInt / 1024;
      // اگر عدد صحیح است، بدون اعشار نشان بده
      if (gb == gb.toInt()) {
        return '${gb.toInt()} گیگابایت';
      }
      return '${gb.toStringAsFixed(1)} گیگابایت';
    }
    return '$trafficInt مگابایت';
  }

  String _formatPrice(dynamic price) {
    int priceInt = int.tryParse(price.toString()) ?? 0;
    return priceInt.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
    );
  }
}




