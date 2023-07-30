import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({
    super.key,
    required this.dataMap,
  });

  final Map<String, double> dataMap;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 2.5,
      colorList: [
        Colors.blue,
        Colors.blueGrey,
        Colors.red,
        Colors.blue.withOpacity(0.5),
        Colors.amber,
        Colors.deepPurple
      ],
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        chartValueStyle:
            TextStyle(color: Colors.white, fontSize: 11.sp, fontFamily: 'Sen'),
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
