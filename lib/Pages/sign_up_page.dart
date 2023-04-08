import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/Common/form/form_header_widget.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/reponsive_builder.dart';
import 'package:meditation_app/Widgets/signup_page_widget/form_body_signup_widget.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

// TextEditingController _userTextController = TextEditingController();
// TextEditingController _passwordTextController = TextEditingController();
// TextEditingController _repasswordTextController = TextEditingController();

//   bool _isHiddenPassword = true;
//   bool _isHiddenRepassword = true;
//   bool _ischecked = false;

  // Future Signin() async{
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: _userTextController.text.trim(),

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
   
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: ReponsiveBuilder(
          portrait: Stack(
            children: [
              SvgPicture.asset(
                imgBackgroundSignUpIn3,
                alignment: const Alignment(0.0, -5),
              ),
              Column(
                children: [
                  form_header_widget(
                      size: Size(size.width * 0.9, size.height * 0.065),
                      sHeight: size.height * 0.4,
                      sWidth: size.width * 1),
                  form_body_signup_widget(
                    
                    size: MaterialStateProperty.all(
                      Size(size.width * 0.9, size.height * 0.065),
                    ),
                    sHeight: size.height * 0.5,
                    sWidth: size.width * 1,
                    sHeightTF: size.height * 0.070,
                    sWidthTF: size.width * 0.9,
                    sFooter: 40,
                  ),
                ],
              ),
            ],
          ),
          landscape: Row(
            children: [
              Expanded(
                  child: form_header_widget(
                size: Size(size.width * 0.35, size.height * 0.15),
                sHeight: size.height * 1,
                sWidth: size.width * 1,
              )),
              Expanded(
                child: form_body_signup_widget(
                
                  size: MaterialStateProperty.all(
                    Size(size.width * 0.4, size.height * 0.065),
                  ),
                  sHeight: size.height * 1,
                  sWidth: size.width * 1,
                  sHeightTF: size.height * 0.15,
                  sWidthTF: size.width * 0.5,
                  sFooter: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
