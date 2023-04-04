import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/container_page.dart';

class AppbarCourseDetailWidget extends StatelessWidget {
  const AppbarCourseDetailWidget({
    super.key,
     this.sWidthIamge,
     this.sHeightImage,
  });
  final double? sWidthIamge, sHeightImage;
  @override
  Widget build(BuildContext context) {
   
    return Stack(
      children: [
        Image.asset(
          imgCourseDetailBg,
          width: sWidthIamge,
          height:sHeightImage,
          fit: BoxFit.fitWidth,
        ),
        Container(
          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      alignment: Alignment.center,
                      onPressed: () {
                        Navigator.of(context).pushNamed('$ContainerPage');
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                      iconSize: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color.fromRGBO(34, 34, 34, 0.475),
                    child: IconButton(
                      alignment: Alignment.center,
                      onPressed: () {},
                      icon: Image.asset(imgCourseDetailHeart),
                      iconSize: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color.fromRGBO(25, 25, 26, 0.475),
                    child: IconButton(
                      alignment: Alignment.center,
                      onPressed: () {
                        //Navigator.of(context).pushNamed('$ContainerPage');
                      },
                      icon: Image.asset(
                        imgCourseDetailDowload,
                      ),
                      color: Colors.white,
                      iconSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
