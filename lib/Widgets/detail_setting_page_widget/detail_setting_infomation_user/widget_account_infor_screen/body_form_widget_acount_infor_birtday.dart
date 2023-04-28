import 'package:flutter/material.dart';
import 'package:meditation_app/Utils/theme.dart';

final ValueNotifier<bool> displayDayList = ValueNotifier<bool>(false);
final ValueNotifier<bool> displayMonthList = ValueNotifier<bool>(false);
final ValueNotifier<bool> displayYearList = ValueNotifier<bool>(false);
List<String> monthList = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12"
];
List<String> dayList = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31"
];
List<String> yearList = [
  "2000",
  "2002",
  "2003",
  "2004",
  "2005",
  "2006",
  "2007",
  "2008",
  "2009",
  "2010",
  "2011",
  "2012",
  "2013",
  "2014",
  "2015",
];

class BodyFormWidgetAcountInforBirtday extends StatelessWidget {
  const BodyFormWidgetAcountInforBirtday({
    super.key,
    required this.day,
    required this.month,
    required this.year,
  });

  final TextEditingController day;
  final TextEditingController month;
  final TextEditingController year;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Day of birt",
          style: Primaryfont.bold(16).copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        ValueListenableBuilder(
          valueListenable: displayDayList,
          builder: (context, value, child) {
            return ValueListenableBuilder(
              valueListenable: displayMonthList,
              builder: (context, value, child) {
                return ValueListenableBuilder(
                  valueListenable: displayYearList,
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            inputField(
                              width: 100.0,
                              text: "Day",
                              controller: day,
                            ),
                            displayDayList.value
                                ? selectionField(
                                    text: "Day",
                                    controller: day,
                                  )
                                : const SizedBox()
                          ],
                        ),
                        Column(
                          children: [
                            inputField(
                              width: 100.0,
                              text: "Month",
                              //data: dayOfBirt[1],
                              controller: month,
                            ),
                            displayMonthList.value
                                ? selectionField(
                                    text: "Month",
                                    controller: month,
                                  )
                                : const SizedBox()
                          ],
                        ),
                        Column(
                          children: [
                            inputField(
                              width: 110.0,
                              text: "Year",
                              //data: dayOfBirt[2],
                              controller: year,
                            ),
                            displayYearList.value
                                ? selectionField(
                                    text: "Year",
                                    controller: year,
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class selectionField extends StatelessWidget {
  selectionField({
    super.key,
    required this.text,
    required this.controller,
  });
  final String text;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 3, // bán kính mờ
              spreadRadius: 1, // bán kính lan rộng
              offset: const Offset(0.0, 0.1), // độ lệch
            ),
          ]),
      child: ListView.builder(
        itemCount: text == "Day"
            ? dayList.length
            : text == "Month"
                ? monthList.length
                : yearList.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              switch (text) {
                case "Day":
                  controller.text = dayList[index];
                  break;
                case "Month":
                  controller.text = monthList[index];
                  break;
                case "Year":
                  controller.text = yearList[index];
                  break;
              }
              displayDayList.value = false;
              displayMonthList.value = false;
              displayYearList.value = false;
            },
            child: ListTile(
              title: Text(
                text == "Day"
                    ? dayList[index]
                    : text == "Month"
                        ? monthList[index]
                        : yearList[index],
                style: Primaryfont.medium(14).copyWith(color: Colors.pink),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class inputField extends StatelessWidget {
  inputField({
    super.key,
    required this.text,
    required this.controller,
    required this.width,
    //required this.data,
  });
  final String text;
  final double width;
  //var data;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 80.0,
      padding: const EdgeInsets.only(bottom: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
          blurRadius: 30,
          offset: const Offset(1, 1),
          color: Colors.pink.withOpacity(0.2),
        ),
      ]),
      child: TextFormField(
        //initialValue: data,
        controller: controller,
        cursorColor: Colors.pink,
        decoration: InputDecoration(
          labelText: text,
          hintStyle: const TextStyle(color: Colors.pink),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: InkWell(
              onTap: () {
                switch (text) {
                  case "Day":
                    displayDayList.value = !displayDayList.value;
                    break;
                  case "Month":
                    displayMonthList.value = !displayMonthList.value;
                    break;
                  case "Year":
                    displayYearList.value = !displayYearList.value;
                    break;
                }
              },
              child: const Icon(
                Icons.arrow_drop_down,
                color: Colors.pink,
              )),
          labelStyle: const TextStyle(color: Colors.pink, fontSize: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
