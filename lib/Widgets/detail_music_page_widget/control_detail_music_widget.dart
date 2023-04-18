import 'package:flutter/material.dart';
import 'package:meditation_app/Common/widget/neubox_widget.dart';
import 'package:meditation_app/Pages/detail_music_favorite_page.dart';

class ControlDetailMusicFavoriteWidget extends StatelessWidget {
  const ControlDetailMusicFavoriteWidget({
    super.key,
    required ValueNotifier<bool> isplay,
    required this.widget,
  }) : _isplay = isplay;

  final ValueNotifier<bool> _isplay;
  final DetailMusicFavorite widget;

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
                      onTap: () async {
                        // //bool play = false;
                        if (_isplay.value == false) {
                          await DarkMode.play.setAsset(widget.duration);
                          await DarkMode.play.play();
                          _isplay.value = true;
                        } else {
                          if (DarkMode.play.playing) {
                            await DarkMode.play.pause();
                            //_isplay.value = false;
                          } else {
                            await DarkMode.play.play();
                            //_isplay.value = true;
                          }
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
