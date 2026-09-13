import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Core/Spacing/app_space.dart';
import '../../../../Core/Theme/app_colors.dart';

class RepetitiveContacts extends StatelessWidget {
  RepetitiveContacts({super.key});

  final List<Map> amountItem = [
    {'id' : 0 ,'userName': 'احسان علی مردانی'},
    {'id' : 1 ,'userName': 'علی شکوری'},
    {'id' : 2 ,'userName': 'جلال بال افکن'},
    {'id' : 3 ,'userName': 'بهروز فرجی'},
    {'id' : 4 ,'userName': 'ساحل معظمی'},
    {'id' : 5 ,'userName': 'الناز اردلانی'},
    {'id' : 6 ,'userName': 'فرهاد حسین زاده'},
    {'id' : 7 ,'userName': 'فرشید نوری'},
    {'id' : 8 ,'userName': 'علیرضا درودیان'},
    {'id' : 9 ,'userName': 'میلاد سرلک'},
    {'id' : 10 ,'userName': 'محمد بخیرایی'}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      height: 142,
      child: SingleChildScrollView(
        child: Column(
          children: [
          Container(
            margin: EdgeInsets.only(right: 24, left: 24),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'مخاطبین پر تکرار',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                    ),
                    Text(
                      'مشاهده همه',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.splashGradiantColor1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          AppSpace.heightSpace_16,

          // --- لیست مخاطبین ---
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              height: 82,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: amountItem.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) => SizedBox(
                  width: 74,
                  height: 82,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          child: SvgPicture.asset(
                            'assets/svg/fund_transfer_page/user-01.svg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      AppSpace.heightSpace_12,
                      Expanded(
                        flex: 1,
                        child: Text(
                          amountItem.elementAt(index)['userName'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryFixed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      )
    );
  }
}
