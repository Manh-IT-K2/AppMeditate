import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:meditation_app/Constant/colors.dart";
import "package:meditation_app/Utils/theme.dart";

class UnclockPremium extends StatefulWidget {
  const UnclockPremium({super.key});

  @override
  State<UnclockPremium> createState() => _UnclockPremiumState();
}

List<String> options = ["Monthly", "Yearly"];
String? selectedOption = "Monthly";
bool changeTxt = true;
class _UnclockPremiumState extends State<UnclockPremium> {
  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          color: const Color(0xFF8E97FD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 20, right: 25),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.cancel,
                      size: 30, color: Color(0xFF0E1F6C)),
                ),
              ),
              titleUnclockPremium(
                title: "Unclock all contents",
                textStyle: Primaryfont.bold(24).copyWith(color: Colors.white),
                alignment: Alignment.center,
              ),
              titleUnclockPremium(
                  title:
                      "Experience Meditopia Premium in full and gain\naccess to 1,000+ pieces of mindfulness content.",
                  textStyle: Primaryfont.thin(14)
                      .copyWith(color: Colors.white, height: 1.4),
                  alignment: Alignment.center),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20),
                child: titleUnclockPremium(
                  title: "What is included?",
                  textStyle: Primaryfont.bold(24).copyWith(color: Colors.white),
                  alignment: Alignment.centerLeft,
                ),
              ),
              componentLibrary(
                  title: "Personal daily meditation guide",
                  icon: Icons.abc,
                  color: Colors.cyan),
              componentLibrary(
                  title: "specially crafted sleep stories and meditations",
                  icon: Icons.dark_mode,
                  color: Colors.orange),
              componentLibrary(
                  title: "Relaxing nature sounds and music",
                  icon: Icons.music_note,
                  color: Colors.green),
              componentLibrary(
                  title: "Offline usage",
                  icon: Icons.cloud_download,
                  color: Colors.purple),
              componentLibrary(
                  title: "Personal daily meditation guide",
                  icon: Icons.light_mode,
                  color: Colors.red),
              Stack(
                children: [
                  choseRadioButtonPremium(
                    txtTitle: "Monthly",
                    txtPrice: "/100.000 VND",
                    optionss: options[0],
                    onChanged: (value) {
                      setState(
                        () {
                          selectedOption = value;
                          changeTxt = true;
                        },
                      );
                    },
                    isSelected: selectedOption == options[0],
                  ),
                  Positioned(
                    top: 10,
                    right: 30,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "7 Days Free",
                          style: Primaryfont.medium(14).copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              choseRadioButtonPremium(
                txtTitle: "Yearly",
                txtPrice: "/1.999.000 VND",
                optionss: options[1],
                onChanged: (value) {
                  setState(
                    () {
                      selectedOption = value;
                      changeTxt = false;
                    },
                  );
                },
                isSelected: selectedOption == options[1],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    titleUnclockPremium(
                      title: "Privacy",
                      alignment: Alignment.center,
                      textStyle:
                          Primaryfont.thin(14).copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    titleUnclockPremium(
                      title: "Terms & Conditions",
                      alignment: Alignment.center,
                      textStyle:
                          Primaryfont.thin(14).copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    titleUnclockPremium(
                      title: "Restore",
                      alignment: Alignment.center,
                      textStyle:
                          Primaryfont.thin(14).copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 80,
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: MaterialButton(
                    onPressed: () {},
                    color: kColorPrimary,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: kColorPrimary,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Continue",
                      style: Primaryfont.bold(16).copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: Text(
                changeTxt ? "Billed monthly as 199.000 VND . cancel anytime" : "Try 7 days for free, then 100.000 VND/month, billed\nannually as 1.099.000 VND/year. Cancel anytime.",
                style: Primaryfont.thin(14),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class choseRadioButtonPremium extends StatelessWidget {
  choseRadioButtonPremium(
      {super.key,
      required this.txtTitle,
      required this.txtPrice,
      required this.optionss,
      required this.isSelected,
      this.onChanged});

  final String txtTitle, txtPrice, optionss;
  final bool isSelected;
  Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: MaterialButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: isSelected ? Colors.white : Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        color: isSelected ? Colors.white : Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: ListTile(
                title: const Text(""),
                leading: Radio(
                  value: optionss,
                  groupValue: selectedOption,
                  onChanged: onChanged,
                  activeColor: kColorPrimary,
                ),
              ),
            ),
            Text(
              txtTitle,
              style: Primaryfont.medium(14).copyWith(color: isSelected ? Colors.black : Colors.white)
            ),
            const SizedBox(
              width: 70,
            ),
            Text(
              txtPrice,
              style: Primaryfont.medium(14).copyWith(color: isSelected ? Colors.black : Colors.white)
            ),
          ],
        ),
      ),
    );
  }
}

class titleUnclockPremium extends StatelessWidget {
  titleUnclockPremium(
      {super.key,
      required this.title,
      required this.alignment,
      required this.textStyle});
  AlignmentGeometry alignment;
  String title;
  TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(title, style: textStyle),
    );
  }
}

class componentLibrary extends StatelessWidget {
  componentLibrary(
      {super.key,
      required this.title,
      required this.icon,
      required this.color});

  IconData icon;
  Color color;
  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 50),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(
                0xFF0E1F6C,
              ),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: Primaryfont.thin(14).copyWith(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}