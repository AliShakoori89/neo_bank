import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../Core/Spacing/app_space.dart';
import '../../../../../../../Core/Widgets/error_refresh_widget.dart';
import '../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_bloc.dart';
import '../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_event.dart';
import '../../../../Bloc/Internet_Packages_Bloc/get_internet_packages_state.dart';
import '../custom_header.dart';
import 'Package_Card_Component/package_card.dart';
import 'internet_package_shimmer.dart';
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

    print(widget.selectedOperator);
    print(packageTimeCode);
    print(widget.selectedSimType);
    print('500');

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
  void initState() {
    _fetchAllPackages(widget.selectedOperator.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(title: 'انتخاب بسته اینترنت', hasBackArrow: false,),
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
                  return Expanded(child: InternetPackageListShimmer(itemCount: 10));
                }else if(state.status.isSuccess){
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.internetPackages!.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final package = state.internetPackages![index];
                        return buildPackageCard(context, package, widget.phoneNumber, widget.selectedOperator);
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


}




