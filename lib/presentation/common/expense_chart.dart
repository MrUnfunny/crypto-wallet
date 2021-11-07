import 'package:cryptowallet/models/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseChart extends StatelessWidget {
  final String name;
  final List<Expense> expenses;
  const ExpenseChart({Key? key, required this.name, required this.expenses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: LineChart(
        sampleData1(),
        swapAnimationDuration: const Duration(milliseconds: 150),
        swapAnimationCurve: Curves.linear,
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
        ),
        touchCallback:
            (FlTouchEvent touch, LineTouchResponse? touchResponse) {},
        handleBuiltInTouches: true,
      ),
      titlesData: FlTitlesData(
        show: false,
        bottomTitles: SideTitles(
          showTitles: true,
          getTitles: (value) => value.toStringAsFixed(1),
        ),
      ),
      gridData: FlGridData(
        show: true,
        getDrawingVerticalLine: (val) {
          return FlLine(
              color: const Color(0xff272C44).withOpacity(0.4), strokeWidth: 1);
        },
        getDrawingHorizontalLine: (val) {
          return FlLine(
              color: const Color(0xff272C44).withOpacity(0.4), strokeWidth: 1);
        },
      ),
      borderData: FlBorderData(
        show: false,
      ),
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final res = List.from(expenses);
    res.removeWhere((element) {
      return (element.currency.name != name);
    });
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: res.map((e) {
        return FlSpot(e?.time.day.toDouble() ?? 0, e?.amount ?? 0);
      }).toList(),
      isCurved: true,
      colors: const [
        Color(0xFFF469BD),
        Color(0xFFB880FF),
      ],
      barWidth: 3,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          Colors.transparent,
          const Color(0xFFB880FF).withOpacity(0.2),
        ],
      ),
    );

    return [
      lineChartBarData1,
    ];
  }
}
