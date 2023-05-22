import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/message/dialog_message.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/detail_setting_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/detail_setting_infomation_user/account_infor_screen.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/model/users_model.dart';

class HeaderWidgetAccountInfor extends StatefulWidget {
  const HeaderWidgetAccountInfor({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.id,
    required this.user,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.day,
    required this.month,
    required this.year,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final String? id;
  final UsersModel user;
  final TextEditingController fullName;
  final TextEditingController email;
  final TextEditingController phone;
  final ValueNotifier<String> gender;
  final TextEditingController day;
  final TextEditingController month;
  final TextEditingController year;

  @override
  State<HeaderWidgetAccountInfor> createState() => _HeaderWidgetAccountInforState();
}

class _HeaderWidgetAccountInforState extends State<HeaderWidgetAccountInfor>  with TickerProviderStateMixin{
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
    _animationController.dispose(); // Hãy chắc chắn rằng bạn đã gọi dispose() trên AnimationController
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final getStatusChageUser = Get.put(EditProfileController());
    final size = context.screenSize;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
                onTap: () {
                  Get.off(() => const DetailSettingUser());
                },
                child: const Icon(Icons.arrow_back_ios, size: 30)),
            const SizedBox(
              width: 10,
            ),
            Text(
              txtEditProfile,
              style: Primaryfont.medium(16),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            if (widget._formKey.currentState!.validate()) {
              if (widget.email.text != "" || widget.phone.text != "") {
                DialogMessage.show(context, "Not enter you must link");
              } else {
                final usersModel = await getStatusChageUser.getUser();
                String? image = usersModel.image;
                int statusChangeUser = usersModel.statusChageUser;
                bool typeImage = usersModel.typeImage;
                final users = UsersModel(
                    id: widget.id,
                    image: image,
                    typeImage: typeImage,
                    statusChageUser: statusChangeUser,
                    userName: widget.user.userName,
                    passWord: widget.user.passWord,
                    fullName: widget.fullName.text.trim(),
                    email: widget.email.text.trim(),
                    phone: widget.phone.text.trim(),
                    gender: widget.gender.value,
                    joinDay: widget.user.joinDay,
                    birtDay:
                        "${widget.day.text.trim()} / ${widget.month.text.trim()} / ${widget.year.text.trim()}");

                await controller.updateUser(users, widget.id!);
                //await Future.delayed(const Duration(seconds: 2));
                SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Align(
                        alignment: Alignment.center,
                        child: SpinKitFadingCircle(
                          color: Colors.pink,
                          size: 50.0,
                          controller: _animationController),
                      ),
                    );
                Get.offAll(() => const AccountInfor());
                Get.snackbar("Success!", "Information has been updated.",
                    icon: const Icon(Icons.error, color: Colors.white),
                    snackPosition: SnackPosition.TOP,
                    duration: const Duration(seconds: 3),
                    backgroundColor: Colors.green,
                    colorText: Colors.white);
              }
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shadowColor: Colors.pink,
              //elevation: 3, // độ bóng của nút
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            "Save",
            style: Primaryfont.bold(16).copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
