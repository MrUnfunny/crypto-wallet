import 'package:cryptowallet/bloc/firestore/firestore_bloc.dart';
import 'package:cryptowallet/config/colors.dart';
import 'package:cryptowallet/models/expense.dart';
import 'package:cryptowallet/presentation/common/custom_bottom_nav_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ThemeColors.backgroundColor,
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            const Color(0xff2D334E),
            const Color(0xff30354F).withOpacity(0.0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF495073),
            offset: Offset(-12, -12),
            blurRadius: 32,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0xFF2E334E),
            offset: Offset(12, 12),
            blurRadius: 32,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0xFF535C88),
            offset: Offset(2, 2),
            blurRadius: 1,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 8.0, top: 26),
            child: Row(
              children: [
                NavItems(
                  icon: const Icon(
                    FontAwesomeIcons.ethereum,
                    color: Color(0xff555FEB),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Expanded(
            child: BlocBuilder<FirestoreBloc, FirestoreState>(
              builder: (context, state) {
                return LineChart(
                  sampleData1(state.userData.expense),
                  swapAnimationDuration: const Duration(milliseconds: 150),
                  swapAnimationCurve: Curves.linear,
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  LineChartData sampleData1(List<Expense> expenses) {
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
      lineBarsData: linesBarData1(expenses),
    );
  }

  List<LineChartBarData> linesBarData1(List<Expense> expenses) {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: expenses.map((e) {
        return FlSpot(e.time.day.toDouble(), e.amount);
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
