import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/started_page_widget/get_started_button_widget.dart';
import 'package:meditation_app/Widgets/started_page_widget/get_started_header_widget.dart';
import 'package:meditation_app/Widgets/started_page_widget/get_stated_background_widget.dart';

class GetstartedPage extends StatelessWidget {
  const GetstartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child:
            context.orientation == Orientation.portrait // reponsive orientation
                ? Stack(
                    children: [
                      const GetStatedBackgound(),
                      const FractionallySizedBox(
                        heightFactor: 0.35,
                        child: GetStatedHeader(),
                      ),
                      Align(
                        alignment: const Alignment(0.0, 0.8),
                        child: GetStartedButton(
                          fixedSize: MaterialStateProperty.all(
                            Size(
                              size.width * 0.9,
                              size.height * 0.065,
                            ),
                          ),
                          textStyle: MaterialStateProperty.all(
                            Primaryfont.medium(size.height * 0.015),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const Expanded(
                          child: Align(
                        alignment: Alignment.topCenter,
                        child: FractionallySizedBox(
                          heightFactor: 0.7,
                          child: GetStatedHeader(),
                        ),
                      )),
                      Expanded(
                        child: Stack(
                          children: [
                            const GetStatedBackgound(),
                            Align(
                              alignment: const Alignment(0.0, 0.7),
                              child: GetStartedButton(
                                fixedSize: MaterialStateProperty.all(
                                  Size(
                                    size.width * 0.4,
                                    size.height * 0.065,
                                  ),
                                ),
                                textStyle: MaterialStateProperty.all(
                                  Primaryfont.medium(size.height * 0.015),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
