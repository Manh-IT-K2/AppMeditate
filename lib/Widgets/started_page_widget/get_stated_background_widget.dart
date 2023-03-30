
import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class GetStatedBackgound extends StatelessWidget {
  const GetStatedBackgound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: context.orientation == Orientation.portrait ? 0.6 : 0.9, //60%
        widthFactor: 1,
        child: FittedBox(
          // rằng buộc thằng con bằng chiều rộng của thàng cha
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          clipBehavior: Clip.antiAlias, // cắt ảnh
          child: Image.asset(tBackgroundGetstartedImage),
        ),
      ),
    );
  }
}