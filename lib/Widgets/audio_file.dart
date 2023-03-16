
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/Utils/theme.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  const AudioFile({super.key, required this.advancedPlayer});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  final String path = "assets/musics/friends/dont coi.mp3";
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;

  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((event) {
      _duration = event;
    });
    widget.advancedPlayer.onPositionChanged.listen((event) {
      setState(() {
        _position = event;
      });
    });

    widget.advancedPlayer.setSource(AssetSource(path));
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false ? Icon(_icons[0], size: 50,color: Colors.blue,) : Icon(_icons[1], size: 50,color: Colors.blue,),
      onPressed: () {
        if (isPlaying == false) {
          widget.advancedPlayer.play(AssetSource(path));
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          widget.advancedPlayer.pause();
          setState(() {
            isPlaying == false;
          });
        }
      },
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          btnStart(),
        ],
      ),
    );
  }

  Widget slider (){
    return Slider(
    activeColor: Colors.red,
    inactiveColor: Colors.grey,
    value: _position.inSeconds.toDouble(), 
    min: 0.0,
    max: _duration.inSeconds.toDouble(),
    onChanged: (double value){
      setState(() {
        changeToSecond(value.toInt());
        value = value;
      });
    });
  }
  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_position.toString().split('.')[0],style: Primaryfont.bold(15).copyWith(color: Colors.grey),),
                Text(_duration.toString().split('.')[0],style: Primaryfont.medium(15).copyWith(color: Colors.grey),),
              ],
            ),
          ),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }
}
