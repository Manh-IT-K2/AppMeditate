import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/Page/detail_setting.dart';
import 'package:meditation_app/Utils/theme.dart';

class UserAfsarPage extends StatefulWidget {
  const UserAfsarPage({super.key});

  @override
  State<UserAfsarPage> createState() => _UserAfsarPageState();
}

class _UserAfsarPageState extends State<UserAfsarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: SafeArea(
        child: Column(
          children: const [
            _appUser(),
            _chartUser(),
            _overviewUser(),
            _otherUser(),
          ],
        ),
      ),
    );
  }
}

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

class _chartUser extends StatelessWidget {
  const _chartUser({
    super.key,
  });

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
                  'Last 7 days',
                  style: Primaryfont.bold(14).copyWith(color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'minute',
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
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 130,
            margin: EdgeInsets.only(top: 20),
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
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: getBottomTitles,
                      ),
                    )),
                barGroups: myBarData.barData
                    .map(
                      (data) => BarChartGroupData(x: data.x, barRods: [
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
                      ]),
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

class _otherUser extends StatelessWidget {
  const _otherUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(bottom: 15),
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kColorPrimary),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Be Premium',
                    style: Primaryfont.bold(14).copyWith(color: Colors.black),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward,
                color: Colors.grey,
                size: 25,
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 15),
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'My favourite',
                    style: Primaryfont.bold(14).copyWith(color: Colors.black),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward,
                color: Colors.grey,
                size: 25,
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 15),
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.download,
                    color: Colors.black,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'My Offline',
                    style: Primaryfont.bold(14).copyWith(color: Colors.black),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward,
                color: Colors.grey,
                size: 25,
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class _overviewUser extends StatelessWidget {
  const _overviewUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overview',
                  style: Primaryfont.bold(14).copyWith(color: Colors.black),
                ),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: Primaryfont.ligh(14)
                          .copyWith(color: kColorDartPrimary),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                      color: Colors.black,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/ic_television.png',
                        color: Colors.black,
                        height: 25,
                      ),
                      Text(
                        'Lesson',
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 2),
                      ),
                      Text(
                        'count',
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 1.2),
                      ),
                      Text(
                        '15',
                        style: Primaryfont.bold(24)
                            .copyWith(color: kColorPrimary, height: 2),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/ic_alarmclock.png',
                        color: Colors.black,
                        height: 25,
                      ),
                      Text(
                        'Meditation',
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 2),
                      ),
                      Text(
                        'Minute',
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 1.2),
                      ),
                      Text(
                        '423',
                        style: Primaryfont.bold(24)
                            .copyWith(color: kColorPrimary, height: 2),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/ic_todolist.png',
                        color: Colors.black,
                        height: 25,
                      ),
                      Text(
                        'Current',
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 2),
                      ),
                      Text(
                        'Streak',
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 1.2),
                      ),
                      Text(
                        '12',
                        style: Primaryfont.bold(24)
                            .copyWith(color: kColorPrimary, height: 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _appUser extends StatelessWidget {
  const _appUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg_favorite.jpeg'),
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Q Mạnh',
                style: Primaryfont.bold(16).copyWith(color: Colors.black),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("$DetailSettingUser");
              
            },
            //borderRadius: BorderRadius.circular(20),
            hoverColor: Colors.transparent,
            child: const Icon(
              Icons.settings_suggest_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
