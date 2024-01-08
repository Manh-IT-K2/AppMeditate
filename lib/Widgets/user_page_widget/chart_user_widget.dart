import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/statistical_controller.dart';

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

class ChartUserWidget extends StatefulWidget {
  const ChartUserWidget({super.key});

  @override
  State<ChartUserWidget> createState() => _ChartUserWidgetState();
}

class _ChartUserWidgetState extends State<ChartUserWidget> {
  late int byTime;
  String choseTime = "Second";
  List listTime = ["Second", "Minute", "Hour"];

  @override
  void initState() {
    byTime = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controllerStatistical = Get.put(StatisticalController());

    // list of weekly expense
    Future<List<double>> fetchWeeklySummary() async {
      return [
        await controllerStatistical.getMeditationOfSunday(byTime),
        await controllerStatistical.getMeditationOfMonday(byTime),
        await controllerStatistical.getMeditationOfTuesday(byTime),
        await controllerStatistical.getMeditationOfWednesday(byTime),
        await controllerStatistical.getMeditationOfThursday(byTime),
        await controllerStatistical.getMeditationOfFriday(byTime),
        await controllerStatistical.getMeditationOfSaturday(byTime),
      ];
    }

    return FutureBuilder<List<double>>(
      future: fetchWeeklySummary(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          // If the data is available, build the widget using the fetched data
          List<double> weekkySummary =
              snapshot.data ?? [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
          BarData myBarData = BarData(
            sunAmount: weekkySummary[0],
            monAmount: weekkySummary[1],
            tueAmount: weekkySummary[2],
            wedAmount: weekkySummary[3],
            thurAmount: weekkySummary[4],
            friAmount: weekkySummary[5],
            satAmount: weekkySummary[6],
          );
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
                        style:
                            Primaryfont.bold(14).copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        width: 65,
                        height: 30,
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(10),
                          value: choseTime,
                          onChanged: (newValue) {
                            setState(() {
                              choseTime = newValue!;
                              if (choseTime == "Second") {
                                byTime = 1;
                              } else if (choseTime == "Minute") {
                                byTime = 60;
                              } else if (choseTime == "Hour") {
                                byTime = 3600;
                              }
                            });
                          },
                          items: listTime
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: Primaryfont.medium(10),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 130,
                  margin: const EdgeInsets.only(top: 20),
                  child: BarChart(
                    BarChartData(
                      maxY: 1000,
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
      },
    );
  }
}
