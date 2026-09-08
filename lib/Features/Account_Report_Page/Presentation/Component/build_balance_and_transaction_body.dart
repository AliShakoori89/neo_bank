import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../Core/Spacing/app_space.dart';
import '../../../../Core/Theme/app_colors.dart';

Widget buildBalanceAndTransactionBody(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.surfaceContainer,
          height: 400,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              bottom: 16,
              top: 30,
              right: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  color: Theme.of(context).colorScheme.surfaceDim,
                ),
                borderRadius: BorderRadius.circular(12),
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
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.splashGradiantColor1,
                          ),
                          AppSpace.widthSpace_5,
                          Text(
                            'موجودی ماه جاری',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              verticalInterval: 30,
                              drawHorizontalLine: true,
                              getDrawingHorizontalLine: (value) => FlLine(
                                color: Theme.of(context).colorScheme.surfaceDim,
                                strokeWidth: 1,
                              ),
                              getDrawingVerticalLine: (value) => FlLine(
                                color: Theme.of(context).colorScheme.surfaceDim,
                                strokeWidth: 1,
                              ),
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),

                              // محور X
                              bottomTitles: AxisTitles(
                                axisNameWidget: Text(
                                  'ماه',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primaryFixed,
                                    fontSize: 12,
                                  ),
                                ),
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 1:
                                        return Text(
                                          '۱',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primaryFixed,
                                            fontSize: 11,
                                          ),
                                        );
                                      case 8:
                                        return Text(
                                          '۸',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primaryFixed,
                                            fontSize: 11,
                                          ),
                                        );
                                      case 15:
                                        return Text(
                                          '۱۵',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primaryFixed,
                                            fontSize: 11,
                                          ),
                                        );
                                      case 23:
                                        return Text(
                                          '۲۳',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primaryFixed,
                                            fontSize: 11,
                                          ),
                                        );
                                      case 30:
                                        return Text(
                                          '۳۰',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primaryFixed,
                                            fontSize: 11,
                                          ),
                                        );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),

                              // محور Y
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 100,
                                  reservedSize: 42,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 100:
                                        return Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Text(
                                            '۱۰۰م',
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primaryFixed,
                                              fontSize: 11,
                                            ),
                                          ),
                                        );
                                      case 200:
                                        return Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Text(
                                            '۲۰۰م',
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primaryFixed,
                                              fontSize: 11,
                                            ),
                                          ),
                                        );
                                      case 300:
                                        return Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Text(
                                            '۳۰۰م',
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primaryFixed,
                                              fontSize: 11,
                                            ),
                                          ),
                                        );
                                      case 400:
                                        return Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Text(
                                            '۴۰۰م',
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primaryFixed,
                                              fontSize: 11,
                                            ),
                                          ),
                                        );
                                      case 500:
                                        return Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Text(
                                            '۵۰۰م',
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primaryFixed,
                                              fontSize: 11,
                                            ),
                                          ),
                                        );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                            minX: 1,
                            maxX: 30,
                            minY: 0,
                            maxY: 500,
                            lineBarsData: [
                              LineChartBarData(
                                isCurved: true,
                                color: Colors.cyanAccent,
                                barWidth: 2.5,
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(show: false),
                                spots: const [
                                  FlSpot(1, 300),
                                  FlSpot(5, 320),
                                  FlSpot(10, 340),
                                  FlSpot(15, 330),
                                  FlSpot(20, 360),
                                  FlSpot(25, 390),
                                  FlSpot(30, 450),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AppSpace.heightSpace_24,
                  ],
                ),
              ),
            ),
          ),
        ),
        AppSpace.heightSpace_24,
        // buildTransactionsList(context),
      ],
    ),
  );
}
