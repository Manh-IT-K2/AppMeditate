import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';

// ignore: must_be_immutable
class RecordCourseDetailWidget extends StatelessWidget {
  RecordCourseDetailWidget({
    super.key,
    required this.futureFavourite,
    required this.futureListten,
  });

  Future<int?> futureListten, futureFavourite;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.black, width: 0.2),
      )),
      child: Row(
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 20,
          ),
          FutureBuilder(
            future: futureFavourite,
            builder: ((context, snapshot) {
              int data = snapshot.data ?? 0;
              String favourite = data.toStringAsFixed(1);
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Text(
                      favourite,
                      style: Primaryfont.ligh(14).copyWith(
                        color: kColorDartPrimary,
                        height: 2,
                      ),
                    ),
                    Text(
                      translation(context).txtCourseDetailHeaderTitleFavorite,
                      style: Primaryfont.ligh(14)
                          .copyWith(color: kColorDartPrimary, height: 1),
                    ),
                  ],
                ),
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 100),
            child: Icon(
              Icons.headphones,
              color: Colors.blue,
              size: 20,
            ),
          ),
          FutureBuilder(
            future: futureListten,
            builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
              int? view = snapshot.data?? 0;
              String views = view.toStringAsFixed(1);
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Text(
                      views,
                      style: Primaryfont.ligh(14).copyWith(
                        color: kColorDartPrimary,
                        height: 2,
                      ),
                    ),
                    Text(
                      translation(context).txtCourseDetailHeaderTitleListening,
                      style: Primaryfont.ligh(14)
                          .copyWith(color: kColorDartPrimary, height: 1),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
