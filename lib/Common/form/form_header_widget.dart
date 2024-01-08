import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/get_started_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/auth_service_controller.dart';
import 'package:meditation_app/controller/forget_password_controller.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/signin_controller.dart';
import 'package:meditation_app/controller/signup_controller.dart';
import 'package:meditation_app/model/users_model.dart';

// ignore: camel_case_types
class form_header_widget extends StatelessWidget {
  const form_header_widget({
    super.key,
    required this.size,
    required this.sHeight,
    required this.sWidth,
  });

  final Size size;
  final double sHeight, sWidth;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthServiceController());
    final createUser = Get.put(SignUpController());
    final dataController = Get.put(DataController());
    final checkEmail = Get.put(ForgetPasswordController());
    final saveLoginSatus = Get.put(SignInController());
    return Container(
      padding: const EdgeInsets.all(0),
      width: sWidth,
      height: sHeight,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                //Navigator.of(context).pushNamed('$SingupOrSignin');
                Get.back();
              },
              icon: Image.asset(imgBack),
              hoverColor: const Color.fromARGB(255, 241, 241, 241),
              iconSize: 50,
            ),
          ),
          Text(
            translation(context).txtHeaderSignup,
            style: Primaryfont.bold(24),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            onPressed: ()async {
              final user = await controller.signInWithFacebook();
              if (user != null) {
                 final String username = await saveLoginSatus.getStringUsername();
                    final User? user = FirebaseAuth.instance.currentUser;
                    final userPass = createUser.generateRandomString(8);
                    final displayName = user!.displayName ?? "";
                    final email = user.email ?? "";
                    if (await checkEmail.checkEmail(email)) {
                      saveLoginSatus.saveUsername(userPass);
                      final userModel = await checkEmail.getUserWithEmail(email);
                      dataController.setUserName(userModel.userName);
                      saveLoginSatus.saveUsername(userPass);
                      saveLoginSatus.saveLoginStatus();
                      Get.to(() => const GetstartedPage(),
                          arguments: dataController.userName.value);
                    } else {
                      saveLoginSatus.saveUsername(userPass);
                      dataController.setUserName(username);
                      saveLoginSatus.saveUsername(userPass);
                      UsersModel usersModel = UsersModel(
                        typeImage: false,
                        statusChageUser: 0,
                        userName: userPass,
                        passWord: userPass,
                        fullName: displayName,
                        email: email,
                      );
                      createUser.creadUser(usersModel);
                      saveLoginSatus.saveLoginStatus();
                      Get.to(() => const GetstartedPage(),
                          arguments: dataController.userName.value);
                    }
                  } else {
                    if (kDebugMode) {
                      print( "User cancels login !");
                    }
                  }
            },
            icon: Image.asset(
              imgFacebook,
              alignment: Alignment.centerLeft,
            ),
            label: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    translation(context).txtWithFacebook,
                    style: Primaryfont.medium(14).copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                backgroundColor: const Color(0xFF7583CA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(38),
                ),
                fixedSize: size),
          ),
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: ElevatedButton.icon(
              onPressed: () async {
                  final user = await controller.signInWithGoogle();
                  if (user != null) {
                    final String username = await saveLoginSatus.getStringUsername();
                    final User? user = FirebaseAuth.instance.currentUser;
                    final userPass = createUser.generateRandomString(8);
                    final displayName = user!.displayName ?? "";
                    final email = user.email ?? "";
                    if (await checkEmail.checkEmail(email)) {
                      saveLoginSatus.saveUsername(userPass);
                      final userModel = await checkEmail.getUserWithEmail(email);
                      dataController.setUserName(userModel.userName);
                      saveLoginSatus.saveUsername(userPass);
                      saveLoginSatus.saveLoginStatus();
                      Get.to(() => const GetstartedPage(),
                          arguments: dataController.userName.value);
                    } else {
                      saveLoginSatus.saveUsername(userPass);
                      dataController.setUserName(username);
                      saveLoginSatus.saveUsername(userPass);
                      UsersModel usersModel = UsersModel(
                        typeImage: false,
                        statusChageUser: 0,
                        userName: userPass,
                        passWord: userPass,
                        fullName: displayName,
                        email: email,
                      );
                      createUser.creadUser(usersModel);
                      saveLoginSatus.saveLoginStatus();
                      Get.to(() => const GetstartedPage(),
                          arguments: dataController.userName.value);
                    }
                  } else {
                    if (kDebugMode) {
                      print( "User cancels login !");
                    }
                  }
                
              },
              icon: Image.asset(imgGoogle),
              label: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Text(
                      translation(context).txtWithGoogle,
                      style:
                          Primaryfont.medium(14).copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38),
                  ),
                  fixedSize: size),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            translation(context).txtwithEmail,
            style: Primaryfont.medium(14).copyWith(
              color: const Color(0xFFA1A4B2),
            ),
          ),
        ],
      ),
    );
  }
}
