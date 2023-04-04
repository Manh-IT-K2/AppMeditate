import 'package:flutter/material.dart';
import 'package:meditation_app/Common/widget/neubox_widget.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';

class ControlDetailMusicWidget extends StatelessWidget {
  const ControlDetailMusicWidget({
    super.key,
    required ValueNotifier<bool> isplay,
    required this.widget,
  }) : _isplay = isplay;

  final ValueNotifier<bool> _isplay;
  final DetailMusic widget;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isplay,
      builder: (context, value, child) {
        return Row(
          children: [
            NeuBox(
              child: SizedBox(
                height: 60,
                width: 60,
                child: Icon(
                  Icons.skip_previous,
                  size: 32,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 80,
                  child: NeuBox(
                    child: InkWell(
                      onTap: () {
                        DarkMode.play.setAsset(widget.duration);
                        if (_isplay.value == false) {
                          DarkMode.play.play();
                          _isplay.value = true;
                        } else if (_isplay.value == true) {
                          DarkMode.play.pause();
                          _isplay.value = false;
                        }
                      },
                      child: Icon(
                        _isplay.value
                            ? Icons.motion_photos_pause_outlined
                            : Icons.play_arrow,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            NeuBox(
              child: SizedBox(
                height: 60,
                width: 60,
                child: Icon(
                  Icons.skip_next,
                  size: 32,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
