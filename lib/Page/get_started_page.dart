
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'chooce_topic_page.dart';

class GetstartedPage extends StatelessWidget {
  const GetstartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: kColorPrimary,
      body: SafeArea(
        // cách khoảng
        child: context.orientation == Orientation.portrait // reponsive orientation
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
                          Primaryfont.medium(size.height * 0.015)),
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
                        heightFactor: 0.7, child: GetStatedHeader()),
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
                                Primaryfont.medium(size.height * 0.015)),
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

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    Key? key,
    this.fixedSize,
    this.textStyle,
  }) : super(key: key);

  final MaterialStateProperty<Size>? fixedSize;
  final MaterialStateProperty<TextStyle>? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('$ChooseTopicPage');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kColorLightGrey),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(38),
        )),
        elevation: MaterialStateProperty.all(0),
        fixedSize: fixedSize,
        foregroundColor: MaterialStateProperty.all(kColorDartGrey),
        textStyle: textStyle,
      ),
      child: const Text("GET STATED"),
    );
  }
}

class GetStatedBackgound extends StatelessWidget {
  const GetStatedBackgound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: context.orientation == Orientation.portrait ? 0.6 : 0.9, //60%
        widthFactor: 1,
        child: FittedBox(
          // rằng buộc thằng con bằng chiều rộng của thàng cha
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          clipBehavior: Clip.antiAlias, // cắt ảnh
          child: Image.asset('assets/images/bg_get_started.png'),
        ),
      ),
    );
  }
}

class GetStatedHeader extends StatelessWidget {
  const GetStatedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ 
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Image.asset(
            'assets/images/ic_logo.png',
            width: 200,
            alignment: const Alignment(0.0, -0.8),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: FittedBox(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Hi afsar ! Wecome\n",
                  style: Primaryfont.medium(30).copyWith(
                    color: kColorLightYellow,
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(
                      text: "To silent Moon !",
                      style: Primaryfont.thin(30).copyWith(
                        color: kColorLightYellow,
                      ),
                    )
                  ]),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SizedBox.expand(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FittedBox(
                  child: Text(
                    "Explore the app, Find some peace of mind\n to prepare for mediatation",
                    style: Primaryfont.ligh(16).copyWith(
                      color: kColorLightGrey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
