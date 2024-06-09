import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';

class AppbarWidget extends StatefulWidget {
  AppbarWidget({
    super.key,
    required this.sBoder,
    required this.sIcon,
    required this.sText,
    required this.colorText,
    required this.sWidthImage,
    required this.sHeightImage,
    required this.sWidthContainer,
    required this.sHeightContainer,
  });
  final double sWidthContainer,
      sHeightContainer,
      sBoder,
      sIcon,
      sText,
      sWidthImage,
      sHeightImage;
  final Color colorText;

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  int selecFunction = 0;

  @override
  Widget build(BuildContext context) {
    const txtFunction = ["All", "My", "Anxious", "Sleep", "Kids"];
    List<IconData> icons = [
      Icons.apps_sharp,
      Icons.favorite_border,
      Icons.emoji_emotions_outlined,
      Icons.mode_night,
      Icons.child_care_outlined
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          5,
          (index) {
            final bool isSelected = selecFunction == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selecFunction = index;
                });
              },
              child: Container(
                height: 109,
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: widget
                          .sWidthContainer, // Set width as per your requirement
                      height: widget
                          .sHeightContainer, // Set height as per your requirement
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? kColorPrimary : kColorDartPrimary,
                      ),
                      child: Icon(
                        icons[index],
                        size: widget.sIcon,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                        height:
                            8), // Adjust the spacing between the icon and text
                    Text(
                      txtFunction[index],
                      style: Primaryfont.ligh(widget.sText).copyWith(
                          color: isSelected ? widget.colorText : Colors.black,
                          height: 1.8),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
