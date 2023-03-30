import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Pages/sign_up_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class SingupOrSignin extends StatelessWidget {
  const SingupOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: context.orientation == Orientation.portrait
            ? Stack(
                children: [
                  FractionallySizedBox(
                    heightFactor: 0.5,
                    widthFactor: 1,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SvgPicture.asset(
                        'assets/images/bg_signup_signin.svg',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      'assets/images/ic_logoBlack.svg',
                      width: size.width * 0.5,
                      alignment: Alignment.center,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 100, right: 20),
                    child: FractionallySizedBox(
                      heightFactor: 0.3,
                      widthFactor: 1,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SvgPicture.asset(
                            'assets/images/img_start.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.0, 0.25),
                    child: Text(
                      "We are what we do",
                      textAlign: TextAlign.center,
                      style: Primaryfont.bold(24).copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.0, 0.40),
                    child: Text(
                      "Thousand of people are usign silent moon\n for smalls meditation",
                      textAlign: TextAlign.center,
                      style: Primaryfont.ligh(14)
                          .copyWith(color: kColorDartGrey, height: 1.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: _Buttons(
                      size: MaterialStateProperty.all(
                        Size(size.width * 0.9, size.height * 0.065),
                      ),
                    ),
                  ),
                  const _TextsButton()
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: const Alignment(0.0, -0.6),
                            child: SvgPicture.asset(
                              'assets/images/ic_logoBlack.svg',
                              width: size.width * 0.3,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "We are what we do",
                              textAlign: TextAlign.center,
                              style: Primaryfont.bold(34).copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Thousand of people are usign silent moon\n for smalls meditation",
                          textAlign: TextAlign.center,
                          style: Primaryfont.ligh(20)
                              .copyWith(color: kColorDartGrey, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: FractionallySizedBox(
                            heightFactor: 0.9,
                            widthFactor: 1,
                            child: SvgPicture.asset(
                              'assets/images/img_start.svg',
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: _Buttons(
                            size: MaterialStateProperty.all(
                              Size(size.width * 0.3, size.height * 0.065),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: _TextsButton(),
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

class _TextsButton extends StatelessWidget {
  const _TextsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0.0, 0.90),
      child: FittedBox(
        child: Row(
          children: [
            Text(
              "ALREADY HAVE AN ACCOUNT?",
              style: Primaryfont.medium(12).copyWith(color: kColorDartPrimary),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "SIGN IN",
                style: Primaryfont.medium(12).copyWith(
                  color: kColorPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    required this.size,
  });

  final MaterialStateProperty<Size> size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0.0, 0.75),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('$SignUp');
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kColorPrimary),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(38),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          fixedSize: size,
        ),
        child: Text(
          "SIGN UP",
          style: Primaryfont.ligh(14).copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
