import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';

// thanh cá nhân
class IndividualBar {
  final int x; // position on x axis
  final double y; // value on y axis

  IndividualBar({required this.x, required this.y});
}

//biểu đồ cột
class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<IndividualBar> barData = [];

  //initialize bar data(khởi tạo dữ liệu thanh)
  void initializeBarData() {
    barData = [
      //sunday
      IndividualBar(x: 0, y: sunAmount),
      //Monday
      IndividualBar(x: 1, y: monAmount),
      //tuesday
      IndividualBar(x: 2, y: tueAmount),
      //Wednesday
      IndividualBar(x: 3, y: wedAmount),
      //thursday
      IndividualBar(x: 4, y: thurAmount),
      //friday
      IndividualBar(x: 5, y: friAmount),
      //saturday
      IndividualBar(x: 6, y: satAmount)
    ];
  }
}
Widget getBottomTitles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        "Sun",
        style: style,
      );
      break;
    case 1:
      text = const Text(
        "Mon",
        style: style,
      );
      break;
    case 2:
      text = const Text(
        "Tue",
        style: style,
      );
      break;
    case 3:
      text = const Text(
        "Wed",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "Thu",
        style: style,
      );
      break;
    case 5:
      text = const Text(
        "Fri",
        style: style,
      );
      break;
    case 6:
      text = const Text(
        "Sat",
        style: style,
      );
      break;
    default:
      text = const Text(
        "",
        style: style,
      );
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
class ChartUserWidget extends StatelessWidget {
  const ChartUserWidget();

  @override
  Widget build(BuildContext context) {
    // list of weekly expense
    List<double> weekkySummary = [
      70.40,
      30.50,
      42.42,
      100.0,
      50.08,
      88.99,
      20.06
    ];
    BarData myBarData = BarData(
        sunAmount: weekkySummary[0],
        monAmount: weekkySummary[1],
        tueAmount: weekkySummary[2],
        wedAmount: weekkySummary[3],
        thurAmount: weekkySummary[4],
        friAmount: weekkySummary[5],
        satAmount: weekkySummary[6]);
    myBarData.initializeBarData();
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      height: 210,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translation(context).txtLast7days,
                  style: Primaryfont.bold(14).copyWith(color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translation(context).txtMinute,
                      style: Primaryfont.ligh(14)
                          .copyWith(color: kColorDartPrimary),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 130,
            margin: const EdgeInsets.only(top: 20),
            child: BarChart(
              BarChartData(
                maxY: 100,
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  drawHorizontalLine: false,
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getBottomTitles,
                    ),
                  ),
                ),
                barGroups: myBarData.barData
                    .map(
                      (data) => BarChartGroupData(
                        x: data.x,
                        barRods: [
                          BarChartRodData(
                            toY: data.y,
                            color: kColorPrimary,
                            width: 25,
                            borderRadius: BorderRadius.circular(5),
                            // backDrawRodData: BackgroundBarChartRodData(
                            //     show: true,
                            //     toY: 120,
                            //     color: Color.fromARGB(255, 233, 232, 232))
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}