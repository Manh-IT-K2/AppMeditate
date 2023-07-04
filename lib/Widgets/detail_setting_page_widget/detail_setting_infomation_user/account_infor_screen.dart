import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/widget/reponsive_builder.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/model/users_model.dart';
import 'widget_account_infor_screen/body_form_widget_account_infor_gender.dart';
import 'widget_account_infor_screen/body_form_widget_account_infor_main.dart';
import 'widget_account_infor_screen/body_form_widget_acount_infor_birtday.dart';
import 'widget_account_infor_screen/header_widget_account_infor.dart';

final controller = Get.put(EditProfileController());

class AccountInfor extends StatefulWidget {
  const AccountInfor({super.key});

  @override
  State<AccountInfor> createState() => _AccountInforState();
}

class _AccountInforState extends State<AccountInfor>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
  }

  @override
  void dispose() {
    _animationController
        .dispose(); // Hãy chắc chắn rằng bạn đã gọi dispose() trên AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    //final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ReponsiveBuilder(
            portrait: Container(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 12),
              child: FutureBuilder<UsersModel?>(
                future: controller.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Align(
                        alignment: Alignment.center,
                        child: SpinKitFadingCircle(
                          color: Colors.pink,
                          size: 50.0,
                          controller: _animationController,
                        ),
                      ),
                    ); // show a loading indicator while waiting for the Future to complete
                  } else 
                  if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // show an error message if the Future returned an error
                  } else if (snapshot.hasData) {
                    // Use the data from the Future if it is not null
                    UsersModel user = snapshot.data!;
                    List<String>? dayOfBirt =
                        user.birtDay?.split('/') ?? ["", "", ""];
                    final fullName =
                        TextEditingController(text: user.fullName ?? "");
                    final email = TextEditingController(text: user.email ?? "");
                    final phone = TextEditingController(text: user.phone ?? "");
                    final day = TextEditingController(text: dayOfBirt[0]);
                    final month = TextEditingController(text: dayOfBirt[1]);
                    final year = TextEditingController(text: dayOfBirt[2]);
                    String image = user.image ?? avtDefault;
                    bool type = user.typeImage;
                    ValueNotifier<String> gender =
                        ValueNotifier<String>(user.gender ?? "");
                    var id = user.id;
                    return Column(
                      children: [
                        HeaderWidgetAccountInfor(
                            //formKey: formKey,
                            id: id,
                            user: user,
                            fullName: fullName,
                            email: email,
                            phone: phone,
                            gender: gender,
                            day: day,
                            month: month,
                            year: year),
                        BodyFormWidgetAccountInforMain(
                            type: type,
                            image: image,
                            fullName: fullName,
                            phone: phone,
                            email: email),
                        BodyFormWidgetAccountInforGender(
                            sWidth: 40, size: size, gender: gender),
                        BodyFormWidgetAcountInforBirtday(
                            day: day, month: month, year: year),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "${translation(context).txtJoined} ${user.joinDay}",
                          style: Primaryfont.bold(12)
                              .copyWith(color: Colors.black),
                        )
                      ],
                    );
                  } else {
                    // Handle the case when the Future returns null
                    return  Center(child: Text(translation(context).txtNoData));
                  }
                },
              ),
            ),
            landscape: Container(
              padding: const EdgeInsets.only(
                  top: 30, left: 30, right: 30, bottom: 12),
              child: FutureBuilder<UsersModel?>(
                future: controller.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Align(
                        alignment: Alignment.center,
                        child: SpinKitFadingCircle(
                          color: Colors.pink,
                          size: 50.0,
                          controller: _animationController,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                        // show an error message if the Future returned an error
                        'Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    // Use the data from the Future if it is not null
                    UsersModel user = snapshot.data!;
                    List<String>? dayOfBirt =
                        user.birtDay?.split('/') ?? ["", "", ""];
                    final fullName =
                        TextEditingController(text: user.fullName ?? "");
                    final email = TextEditingController(text: user.email ?? "");
                    final phone = TextEditingController(text: user.phone ?? "");
                    final day = TextEditingController(text: dayOfBirt[0]);
                    final month = TextEditingController(text: dayOfBirt[1]);
                    final year = TextEditingController(text: dayOfBirt[2]);
                    String image = user.image ?? avtDefault;
                    bool type = user.typeImage;
                    ValueNotifier<String> gender =
                        ValueNotifier<String>(user.gender ?? "");
                    var id = user.id;
                    return Column(
                      children: [
                        HeaderWidgetAccountInfor(
                            //formKey: formKey,
                            id: id,
                            user: user,
                            fullName: fullName,
                            email: email,
                            phone: phone,
                            gender: gender,
                            day: day,
                            month: month,
                            year: year),
                        BodyFormWidgetAccountInforMain(
                            type: type,
                            image: image,
                            fullName: fullName,
                            phone: phone,
                            email: email),
                        BodyFormWidgetAccountInforGender(
                            sWidth: 150, size: size, gender: gender),
                        BodyFormWidgetAcountInforBirtday(
                            day: day, month: month, year: year),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "${translation(context).txtJoined} ${user.joinDay}",
                          style: Primaryfont.bold(12)
                              .copyWith(color: Colors.black),
                        )
                      ],
                    );
                  } else {
                    // Handle the case when the Future returns null
                    return  Center(child: Text(translation(context).txtNoData));
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
