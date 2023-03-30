import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Pages/container_page.dart';

const dayofWeek = ["SU", "MO", "TU", "WE", "TH", "FR", "SA"];

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: context.orientation == Orientation.portrait
          ? SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, //
                children: const [
                  Spacer(),
                  Expanded(
                      flex: 2,
                      child: _Title(
                        title: "What time would you\n like to meditate?",
                        subtitle:
                            "Any time you can choose but we recommend\n firts thing in the morning.",
                      )),
                  Expanded(
                    flex: 3,
                    child: _TimeSelects(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      flex: 2,
                      child: _Title(
                        title: "What day would you\n like to meditate?",
                        subtitle:
                            "Everyday is best, but we recomend\n picking at least five.",
                      )),
                  Expanded(
                    child: _DaySelects(),
                  ),
                  Expanded(
                    flex: 2,
                    child: _Buttons(),
                  ),
                ],
              ),
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    children: const [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 30, left: 30),
                          child: _Title(
                            title: "What time would you\n like to meditate?",
                            subtitle:
                                "Any time you can choose but we recommend\n firts thing in the morning.",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, bottom: 30),
                          child: _TimeSelects(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: const [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: _Title(
                            title: "What day would you\n like to meditate?",
                            subtitle:
                                "Everyday is best, but we recomend\n picking at least five.",
                          ),
                        ),
                      ),
                      Expanded(
                        child: _DaySelects(),
                      ),
                      Expanded(
                        flex: 2,
                        child: _Buttons(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _TimeSelects extends StatelessWidget {
  const _TimeSelects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // hours wheel
            SizedBox(
              width: 50,
              child: ListWheelScrollView.useDelegate(
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1.2,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 13,
                  builder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        index.toString(),
                        style:
                            Primaryfont.bold(24).copyWith(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),

            // minutes wheel
            SizedBox(
              width: 50,
              child: ListWheelScrollView.useDelegate(
                //onSelectedItemChanged: (value) => print(value),
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1.2,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 60,
                    builder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          index < 10
                              ? '0' + index.toString()
                              : index.toString(),
                          style: Primaryfont.bold(24)
                              .copyWith(color: Colors.black),
                        ),
                      );
                    }),
              ),
            ),
            // AM or PM
            SizedBox(
              width: 50,
              child: ListWheelScrollView.useDelegate(
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1.2,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 2,
                  builder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        index == 0 ? 'AM' : 'PM',
                        style:
                            Primaryfont.bold(24).copyWith(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DaySelects extends StatelessWidget {
  const _DaySelects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          7,
          (index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: const Color(0xFFA1A4B2),
                    ),
                  ),
                  child: Center(
                    child: Text(dayofWeek[index]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('$ContainerPage');
              },
              textColor: Colors.white,
              color: kColorPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(38),
              ),
              child: Text(
                "Save",
                style: Primaryfont.medium(14),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "NO THANKS",
                style: Primaryfont.medium(14).copyWith(color: kColorDartGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // các thằng con trong column giãn ra hết chiều rộng của màn hình
        children: [
          Expanded(
            child: FractionallySizedBox(
              heightFactor: 0.8,
              alignment: Alignment.topCenter,
              child: FittedBox(
                // cho thằng con co lại đúng bằng fractionallysizebox
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: Primaryfont.bold(24).copyWith(
                    height: 1.35,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FractionallySizedBox(
              heightFactor: 0.6,
              alignment: Alignment.topCenter,
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(
                  subtitle,
                  style: Primaryfont.ligh(14).copyWith(
                    color: const Color(0xFFA1A4B2),
                    height: 1.65,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
