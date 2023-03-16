import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/Page/sign_in_page.dart';
import 'package:meditation_app/Page/signup_or_singin_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<SignUp> {
  bool _isHiddenPassword = true;
  bool _isHiddenRepassword = true;
  bool _ischecked = false;
  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: context.orientation == Orientation.portrait
            ? Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/bg_signin.svg',
                    alignment: const Alignment(0.0, -5),
                  ),
                  Column(
                    children: [
                      const _ButtonBack(),
                      Text(
                        "Create your account",
                        style: Primaryfont.bold(24),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _ButtonFacebook(
                          size: Size(size.width * 0.9, size.height * 0.065)),
                      const SizedBox(
                        height: 20,
                      ),
                      _ButtonGoogle(
                          size: Size(size.width * 0.9, size.height * 0.065)),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "OR LOG IN WITH EMAIL",
                        style: Primaryfont.medium(14)
                            .copyWith(color: const Color(0xFFA1A4B2)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const _TextfieldUser(),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  offset: const Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.1))
                            ]),
                        child: SizedBox(
                          height: size.height * 0.065,
                          width: size.width * 0.9,
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isHiddenPassword,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Image.asset('assets/images/ic_lock.png'),
                              fillColor: const Color(0xFFF2F3F7),
                              filled: true,
                              hintText: 'Password',
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1.0),
                              ),
                              suffix:
                                  //Image.asset('assets/images/ic_hide.png'),
                                  InkWell(
                                onTap: () {
                                  setState(() {
                                    _isHiddenPassword = !_isHiddenPassword;
                                  });
                                },
                                child: Icon(
                                  _isHiddenPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  offset: const Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.1))
                            ]),
                        child: SizedBox(
                          height: size.height * 0.065,
                          width: size.width * 0.9,
                          child: TextField(
                            obscureText: _isHiddenRepassword,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                prefixIcon:
                                    Image.asset('assets/images/ic_lock.png'),
                                fillColor: const Color(0xFFF2F3F7),
                                filled: true,
                                hintText: 'Repassword',
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1.0),
                                ),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isHiddenRepassword =
                                          !_isHiddenRepassword;
                                    });
                                  },
                                  child: Icon(
                                    _isHiddenRepassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: FittedBox(
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: 'i have read the\t',
                                    style: Primaryfont.medium(14).copyWith(
                                      color: kColorDartPrimary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Privace Policy',
                                        style: Primaryfont.medium(14).copyWith(
                                            color: kColorPrimary, height: 2),
                                      ),
                                    ]),
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              Checkbox(
                                value: _ischecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _ischecked = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('$SignIn');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kColorPrimary),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(0),
                          fixedSize: MaterialStateProperty.all(
                            Size(size.width * 0.9, size.height * 0.065),
                          ),
                        ),
                        child: Text(
                          "SIGN UP",
                          style: Primaryfont.bold(14)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const _ButtonBack(),
                        Text(
                          "Create your account",
                          style: Primaryfont.bold(24),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        _ButtonFacebook(
                            size: Size(size.width * 0.35, size.height * 0.15)),
                        const SizedBox(
                          height: 20,
                        ),
                        _ButtonGoogle(
                            size: Size(size.width * 0.35, size.height * 0.15)),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "OR LOG IN WITH EMAIL",
                          style: Primaryfont.medium(14)
                              .copyWith(color: const Color(0xFFA1A4B2)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const _TextfieldUser(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    offset: const Offset(1, 1),
                                    color: Colors.grey.withOpacity(0.1))
                              ]),
                          child: SizedBox(
                            height: size.height * 0.15,
                          width: size.width * 0.5,
                            child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _isHiddenPassword,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Image.asset('assets/images/ic_lock.png'),
                                fillColor: const Color(0xFFF2F3F7),
                                filled: true,
                                hintText: 'Password',
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1.0),
                                ),
                                suffix:
                                    //Image.asset('assets/images/ic_hide.png'),
                                    InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isHiddenPassword = !_isHiddenPassword;
                                    });
                                  },
                                  child: Icon(
                                    _isHiddenPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    offset: const Offset(1, 1),
                                    color: Colors.grey.withOpacity(0.1))
                              ]),
                          child: SizedBox(
                           height: size.height * 0.15,
                          width: size.width * 0.5,
                            child: TextField(
                              obscureText: _isHiddenRepassword,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                prefixIcon:
                                    Image.asset('assets/images/ic_lock.png'),
                                fillColor: const Color(0xFFF2F3F7),
                                filled: true,
                                hintText: 'Repassword',
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1.0),
                                ),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isHiddenRepassword = !_isHiddenRepassword;
                                    });
                                  },
                                  child: Icon(
                                    _isHiddenRepassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: 'i have read the\t',
                                    style: Primaryfont.medium(14).copyWith(
                                      color: kColorDartPrimary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Privace Policy',
                                        style: Primaryfont.medium(14).copyWith(
                                            color: kColorPrimary, height: 2),
                                      ),
                                    ]),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Checkbox(
                                value: _ischecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _ischecked = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('$SignIn');
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kColorPrimary),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(38),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(0),
                              fixedSize: MaterialStateProperty.all(
                                Size(size.width * 0.2, size.height * 0.1),
                              ),
                            ),
                            child: Text(
                              "SIGN UP",
                              style: Primaryfont.bold(14)
                                  .copyWith(color: Colors.white),
                            ),
                            )
                      ],
                    ),
                  ),
                ],
              ),
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
            color: Colors.grey.withOpacity(0.1))
      ]),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Image.asset('assets/images/ic_user.png'),
          fillColor: const Color(0xFFF2F3F7),
          filled: true,
          hintText: 'Username',
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.transparent, width: 1.0),
          ),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.transparent, width: 1.0)),
        ),
      ),
    );
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
    return Flexible(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Image.asset('assets/images/ic_google.png'),
        label: Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Text(
                'CONTINUE WITH GOOGLE',
                style: Primaryfont.medium(14).copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
            fixedSize: size),
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
      icon: Image.asset(
        'assets/images/ic_facebook.png',
        alignment: Alignment.centerLeft,
      ),
      label: Row(
        children: [
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Text(
              'CONTINUE WITH FACEBOOK',
              style: Primaryfont.medium(14).copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          backgroundColor: const Color(0xFF7583CA),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
          fixedSize: size),
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
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed('$SingupOrSignin');
        },
        icon: Image.asset('assets/images/ic_back.png'),
        hoverColor: const Color.fromARGB(255, 241, 241, 241),
        iconSize: 50,
      ),
    );
  }
}
