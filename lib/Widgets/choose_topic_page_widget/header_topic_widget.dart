import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class HeaderChooseTopicWidget extends StatelessWidget {
  const HeaderChooseTopicWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(
            flex: 3,
          ),
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, //làm cho thằng con rộng hết chiều rộng ra
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // thêm khoảng trống đều ở phía trên và phía dưới những thằng con
              children: [
                Expanded(
                  child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        txtHeaderChooseTopicTitle1,
                        style: Primaryfont.bold(28),
                      )),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        txtHeaderChooseTopicTitle2,
                        style: Primaryfont.ligh(24),
                      )),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Flexible(
              flex: 1,
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(
                  txtHeaderChooseTopicSubTitle1,
                  style: Primaryfont.ligh(20)
                      .copyWith(color: const Color(0xFFA1A4B2)),
                ),
              )),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
