import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/statistical_controller.dart';
import 'package:meditation_app/model/musics_model.dart';

class FooterHomeWidget extends StatefulWidget {
  const FooterHomeWidget({
    super.key,
    required this.imgHeight,
    required this.imgWidth,
    required this.sTextHeader,
    required this.sTextSubTitle,
    required this.sTextTitle,
    required this.sbWidth,
    required this.sContainerHeight,
  });
  final double sbWidth,
      imgWidth,
      imgHeight,
      sTextHeader,
      sTextTitle,
      sTextSubTitle,
      sContainerHeight;

  @override
  State<FooterHomeWidget> createState() => _FooterHomeWidgetState();
}

class _FooterHomeWidgetState extends State<FooterHomeWidget> with TickerProviderStateMixin{
  late AnimationController  _animationController;
  @override
  void initState(){
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    super.initState();
  }
  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatisticalController());
    final dataController = Get.put(DataController());
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20.0, left: 12.0),
          alignment: Alignment.centerLeft,
          child: Text(
            translation(context).txtRecomended,
            style: Primaryfont.bold(widget.sTextHeader).copyWith(color: Colors.black),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(top: 20, bottom: 20, left: 12, right: 12),
          height: widget.sContainerHeight,
          child: FutureBuilder<List<MusicsModel>>(
            future: controller.getMusicByMostViews(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                if (kDebugMode) {
                  print("Error load music by most views : ${snapshot.error}");
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitFadingCircle(
                  color: Colors.pink,
                  size: 50.0,
                  controller: _animationController,
                );
              }
              List<MusicsModel> items = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  // Xác định nếu là phần tử cuối cùng để không có khoảng cách sau cùng
                  bool isLastItem = index == items.length - 1;
                  return InkWell(
                    onTap: () {
                      SaveChange.checkMusicImage = false;
                      Get.to(DetailMusic(
                          bgColor: kColorLightGrey,
                          imageBg: imgMusicsBackGround,
                          color: Colors.black,
                          imageRelay: imgMusicIconRelayBright,
                          imageForward: imgMusicIconSkipBright,), arguments: {
                             "musicId": dataController.musicId.value =
                              items[index].id,
                          "musicTitle": dataController.musicTitle.value =
                              items[index].title,
                          "musicAuthor": dataController.musicAuthor.value =
                              items[index].author,
                          "musicImage": dataController.musicImage.value =
                              items[index].image,
                          "musicUrl": dataController.musicUrl.value =
                              items[index].url,
                        });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: isLastItem ? 0 : 10),
                      child: buildCard(
                        item: items[index],
                        sbWidth: widget.sbWidth,
                        sTextTitle: widget.sTextTitle,
                        sTextSubTitle: widget.sTextSubTitle,
                        imgHeight: widget.imgHeight,
                        imgWidth: widget.imgWidth,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget buildCard({
  required MusicsModel item,
  required double sTextTitle,
  sTextSubTitle,
  sbWidth,
  imgWidth,
  imgHeight,
}) =>
    SizedBox(
      width: sbWidth,
      //height: 180,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Material(
                  child: Ink.image(
                    image: NetworkImage(item.image),
                    width: imgWidth,
                    height: imgHeight,
                    fit: BoxFit.cover,
                    
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: const Alignment(-0.9, 0.0),
            child: Text(
              item.title,
              style: Primaryfont.medium(sTextTitle).copyWith(color: Colors.black),
              overflow: TextOverflow.ellipsis, // Hiển thị ba dấu chấm khi xuống hàng
              maxLines: 1, // Giới hạn hiển thị chỉ trên một dòng
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: const Alignment(-0.9, 0.0),
            child: Text(
              txtCaditemHomeSubTitle,
              style: Primaryfont.ligh(sTextSubTitle)
                  .copyWith(color: kColorDartPrimary),
            ),
          ),
        ],
      ),
    );
