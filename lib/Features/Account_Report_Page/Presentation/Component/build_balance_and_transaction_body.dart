import 'package:flutter/material.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:neo_bank_mehr_iran/Core/Const/app_space.dart';

import '../../../Home_Page/Presentation/Component/transactions_list.dart';


Widget buildBalanceAndTransactionBody(BuildContext context){
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          color: AppColors.appWhite,
          height: 400,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              bottom: 16,
              top: 30,
              right: 20
            ),
            child: Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  color: AppColors.homePageDividerColor,
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.circle,
                            size: 8,
                            color: AppColors.splashGradiantColor1,),
                          AppSpace.widthSpace_5,
                          Text('موجودی ماه جاری',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.loginPageTextColor
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  String text;
                                  switch (value.toInt()) {
                                    case 0:
                                      text = '۰';
                                      break;
                                    case 1:
                                      text = '۱';
                                      break;
                                    case 2:
                                      text = '۲';
                                      break;
                                    case 3:
                                      text = '۳';
                                      break;
                                    case 4:
                                      text = '۴';
                                      break;
                                    case 5:
                                      text = '۵';
                                      break;
                                    case 6:
                                      text = '۶';
                                      break;
                                    default:
                                      text = '';
                                      break;
                                  }
                                  return Text(
                                    text,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 500,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  if (value % 500 == 0) {
                                    return Text(
                                      '${value ~/ 100}۰۰۰',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.grey),
                          ),
                          minX: 0,
                          maxX: 6,
                          minY: 0,
                          maxY: 2000,
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 200),
                                FlSpot(1, 400),
                                FlSpot(2, 800),
                                FlSpot(3, 1200),
                                FlSpot(4, 1500),
                                FlSpot(5, 1800),
                                FlSpot(6, 1900),
                              ],
                              isCurved: true,
                              color: AppColors.splashGradiantColor1, // در نسخه جدید دیگه colors لیست نیست
                              barWidth: 3,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blue.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('ماه'),
                    ),
                  ],
                ),
              ),
            )
          ),
        ),
        AppSpace.heightSpace_24,
        buildTransactionsList(context),
      ],
    ),
  );
}