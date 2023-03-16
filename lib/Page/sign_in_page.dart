import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/Page/get_started_page.dart';
import 'package:meditation_app/Page/sign_up_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<SignIn> {
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: Colors.white,
      body: context.orientation == Orientation.portrait
          ? Stack(
              children: [
                // img background
                SvgPicture.asset(
                  'assets/images/bg_signin.svg',
                  width: size.width,
                ),
                // button back
                Column(
                  children: [
                    const _ButtonBack(),
                    // text title
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Welcome Back!',
                      textAlign: TextAlign.center,
                      style: Primaryfont.bold(24),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _ButtonFacebook(
                      size: Size(size.width * 0.9, size.height * 0.065),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    _ButtonGoogle(
                        size: Size(size.width * 0.9, size.height * 0.065)),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'OR LOG IN WITH EMAIL',
                      style: Primaryfont.medium(14)
                          .copyWith(color: kColorDartPrimary),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const _TextfieldUser(),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                          ]),
                      child: TextField(
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('assets/images/ic_lock.png'),
                          fillColor: const Color(0xFFF2F3F7),
                          filled: true,
                          hintText: 'Password',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                _isHidden = !_isHidden;
                              });
                            },
                            child: Icon(
                              _isHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _ButtonSignin(
                        size: MaterialStateProperty.all(
                            Size(size.width * 0.9, size.height * 0.065))),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?',
                          style: Primaryfont.medium(14)
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.085,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          Text('ALREADY HAVE AN ACCOUNT?\t',
                              style: Primaryfont.medium(14)
                                  .copyWith(color: kColorDartPrimary)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('$SignUp');
                            },
                            child: Text(
                              'SIGN UP',
                              style: Primaryfont.medium(14)
                                  .copyWith(color: kColorPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const _ButtonBack(),
                      // text title
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Welcome Back!',
                        textAlign: TextAlign.center,
                        style: Primaryfont.bold(24),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _ButtonFacebook(
                        size: Size(size.width * 0.35, size.height * 0.15),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      _ButtonGoogle(
                          size: Size(size.width * 0.35, size.height * 0.15)),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'OR LOG IN WITH EMAIL',
                        style: Primaryfont.medium(14)
                            .copyWith(color: kColorDartPrimary),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const _TextfieldUser(),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            ]),
                        child: SizedBox(
                          width: size.width * 0.5,
                          height: size.height * 0.15,
                          child: TextField(
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Image.asset('assets/images/ic_lock.png'),
                              fillColor: const Color(0xFFF2F3F7),
                              filled: true,
                              hintText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isHidden = !_isHidden;
                                  });
                                },
                                child: Icon(
                                  _isHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _ButtonSignin(
                          size: MaterialStateProperty.all(
                              Size(size.width * 0.3, size.height * 0.1))),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot password?',
                            style: Primaryfont.medium(14)
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            Text('ALREADY HAVE AN ACCOUNT?\t',
                                style: Primaryfont.medium(14)
                                    .copyWith(color: kColorDartPrimary)),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('$SignUp');
                              },
                              child: Text(
                                'SIGN UP',
                                style: Primaryfont.medium(14)
                                    .copyWith(color: kColorPrimary),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _TextfieldUser extends StatelessWidget {
  const _TextfieldUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
        BoxShadow(
          blurRadius: 10,
          offset: const Offset(1, 1),
          color: Colors.grey.withOpacity(0.1),
        ),
      ]),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Image.asset('assets/images/ic_user.png'),
          fillColor: const Color(0xFFF2F3F7),
          filled: true,
          hintText: 'Username',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
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

class _ButtonBack extends StatelessWidget {
  const _ButtonBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('$SignUp');
          },
          icon: Image.asset('assets/images/ic_back.png'),
          iconSize: 50,
          alignment: Alignment.centerLeft,
          hoverColor: Colors.transparent,
        ),
      ),
    );
  }
}

class _ButtonSignin extends StatelessWidget {
  const _ButtonSignin({
    super.key,
    required this.size,
  });

  final MaterialStateProperty<Size> size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('$GetstartedPage');
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
          'SIGN IN',
          style: Primaryfont.medium(14).copyWith(color: Colors.white),
        ));
  }
}

class _ButtonGoogle extends StatelessWidget {
  const _ButtonGoogle({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Image.asset('assets/images/ic_google.png'),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
          fixedSize: size),
      label: Row(
        children: [
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Text(
              "CONTINUE WITH GOOGLE",
              style: Primaryfont.medium(14).copyWith(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}

class _ButtonFacebook extends StatelessWidget {
  const _ButtonFacebook({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        backgroundColor: const Color(0xFF7583CA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(38),
        ),
        fixedSize: size,
      ),
      icon: Image.asset(
        'assets/images/ic_facebook.png',
        alignment: Alignment.center,
      ),
      label: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 40,
          ),
          Expanded(
            child: Text(
              'CONTINUE WITH FACEBOOK',
              style: Primaryfont.medium(14).copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
