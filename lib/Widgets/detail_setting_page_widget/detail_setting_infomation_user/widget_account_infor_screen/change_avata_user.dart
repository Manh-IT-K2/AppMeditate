import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditation_app/Common/message/dialog_message.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/detail_setting_infomation_user/account_infor_screen.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/model/users_model.dart';
import 'package:permission_handler/permission_handler.dart';

File? imageFile;
final contronller = Get.put(EditProfileController());
late String userId;

class ChageAvataUser {
  // ignore: non_constant_identifier_names
  Future<dynamic> BuildShowmodalBottomSheet(
      BuildContext context, Color color, String image) {
    final size = context.screenSize;
    List<Color> colors = [
      Colors.black,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.pink,
      Colors.cyan,
      Colors.grey,
      Colors.brown,
      Colors.orange,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepPurple,
      Colors.teal,
      Colors.lime,
      Colors.purple,
    ];
    List<String> avts = [
      avtDefault,
      avt2,
      avt3,
      avt4,
      avt5,
      avt6,
      avt7,
      avt8,
      avt9,
      avt10,
      avt11,
      avt12,
      avt13,
      avt14,
      avt15,
      avt16,
    ];

    // get index in list colors
    int positionColor() {
      int indexx = 0;
      List<Color> convertedColors = colors.map((colorr) {
        String colorString = colorr.value.toRadixString(16).padLeft(8, '0');
        return Color(int.parse(colorString, radix: 16));
      }).toList();

      for (int i = 0; i < convertedColors.length; i++) {
        if (color == convertedColors[i]) {
          indexx = i;
        }
      }
      return indexx;
    }

    // get index in list avts
    int positionAvt() {
      int indexx = 0;
      for (int i = 0; i < avts.length; i++) {
        if (image == avts[i]) {
          indexx = i;
        }
      }
      return indexx;
    }

    final ValueNotifier<int> selectedColorIndex =
        ValueNotifier<int>(positionColor());
    final ValueNotifier<int> selectedAvataIndex =
        ValueNotifier<int>(positionAvt());
    return showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding:
              const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage,
                    Permission.camera,
                  ].request();
                  if (statuses[Permission.storage]!.isGranted &&
                      statuses[Permission.camera]!.isGranted) {
                    // ignore: use_build_context_synchronously
                    showImagePicker(context);
                  } else {
                    // ignore: use_build_context_synchronously
                    DialogMessage.show(context, "No permission provided.");
                  }
                },
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: kColorPrimary,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose border color",
                  style: Primaryfont.bold(20).copyWith(color: Colors.black),
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                children: List<Widget>.generate(
                  colors.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 5, right: 3, left: 3),
                      child: ValueListenableBuilder(
                        valueListenable: selectedColorIndex,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () {
                              selectedColorIndex.value = index;
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors[index],
                                border: Border.all(
                                  color: selectedColorIndex.value == index
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.5), // Màu và độ mờ của bóng đổ
                                    spreadRadius: 3, // Độ rộng của bóng đổ
                                    blurRadius: 5, // Độ mờ của bóng đổ
                                    offset: const Offset(2,
                                        2), // Vị trí của bóng đổ (dọc và ngang)
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose avata",
                  style: Primaryfont.bold(20).copyWith(color: Colors.black),
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                children: List<Widget>.generate(
                  avts.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 5, right: 3, left: 3),
                      child: ValueListenableBuilder(
                        valueListenable: selectedAvataIndex,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () {
                              selectedAvataIndex.value = index;
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(avts[index])),
                                border: Border.all(
                                  color: selectedAvataIndex.value == index
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.1), // Màu và độ mờ của bóng đổ
                                    spreadRadius: 2, // Độ rộng của bóng đổ
                                    blurRadius: 5, // Độ mờ của bóng đổ
                                    offset: const Offset(0,
                                        2), // Vị trí của bóng đổ (dọc và ngang)
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  UsersModel user = await contronller.getUser();
                  userId = user.id!;
                  final image = avts[selectedAvataIndex.value];
                  bool type = false;
                  contronller.saveColor(colors[selectedColorIndex.value]);
                  controller.updateTypeImage(userId, type);
                  contronller.updateAvata(userId, image);
                  Get.offAll(() => const AccountInfor());
                },
                child: Text(
                  "Save change ?",
                  style: Primaryfont.bold(20).copyWith(color: Colors.lightBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final picker = ImagePicker();
  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    child: const Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 60.0,
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          "Gallery",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Camera",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // crop image from gallery
  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  // crop image from camera
  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  // crop image
  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      UsersModel user = await contronller.getUser();
      userId = user.id!;
      imageFile = File(croppedFile.path);
      String file = imageFile!.path;
      bool type = true;
      controller.updateTypeImage(userId, type);
      controller.updateAvata(userId, file);
      Get.offAll(() => const AccountInfor());
    }
  }
}
