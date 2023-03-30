import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/animation/controller/fade_in_animation_controller.dart';
import 'package:meditation_app/Common/animation/model/fade_in_animation_model.dart';

class TFadeInAnimation extends StatelessWidget {
  TFadeInAnimation({
    super.key,
    required this.durationInMs,
    this.animatePosition,
    required this.child,
  });

  final controller = Get.put(FadeInAnimationController());
  final int durationInMs;
  final TAnimatePosition? animatePosition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: durationInMs),
        top: controller.animate.value ? animatePosition!.topAfter : animatePosition!.topBefore,
        left: controller.animate.value ? animatePosition!.leftAfter : animatePosition!.leftBefore,
        bottom: controller.animate.value ? animatePosition!.bottomAfter : animatePosition!.bottomBefore,
        right: controller.animate.value ? animatePosition!.rightAfter : animatePosition!.rightBefore,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: durationInMs),
          opacity: controller.animate.value ? 1 : 0,
          child: child,
        ),
      ),
    );
  }
}
