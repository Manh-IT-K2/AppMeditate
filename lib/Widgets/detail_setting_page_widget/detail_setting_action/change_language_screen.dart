import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/main.dart';
import 'package:meditation_app/model/language_model.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isLoading = false;

  void _navigateToNewPage() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      // Thực hiện chuyển đến trang khác sau 3 giây
      Get.offAll(() => const ContainerPage());
      SaveChange.indexPage = 2;
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Hãy chắc chắn rằng bạn đã gọi dispose() trên AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    List<LanguageModel> listLanguage = LanguageModel.listLanguage();
    return isLoading
        ? Container(
            color: Colors.white,
            width: size.width,
            height: size.height,
            child: Align(
              alignment: Alignment.center,
              child: SpinKitFadingCircle(
                  color: Colors.pink,
                  size: 50.0,
                  controller: _animationController),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    color: Colors.black,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          translation(context).txtBack,
                          style: Primaryfont.medium(14)
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    width: size.width,
                    height: 350,
                    child: GifView.asset(imgBgChangeLanguage),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.4,
                    child: ListView.builder(
                      itemCount: listLanguage.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kColorLightGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () async {
                                Locale locale = await setLocale(listLanguage[index].languageCode);
                                // ignore: use_build_context_synchronously
                                MyApp.setLocale(context, locale);
                                _navigateToNewPage();
                              },
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    listLanguage[index].flag,
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  Text(
                                    listLanguage[index].name,
                                    style: Primaryfont.medium(14)
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
