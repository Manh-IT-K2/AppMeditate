import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Repository/music_repository.dart';
import 'package:meditation_app/controller/topics_contronller.dart';
import 'package:meditation_app/model/musics_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicController extends GetxController {
  static MusicController get instance => Get.find();
  final musicRepo = Get.put(MusicRepository());
  final idTopic = Get.put(TopicController());

  // get all music
Future<List<MusicsModel>?> getAllMusic() async {
  try {
    String id = await idTopic.getChoseTopic();
    return await musicRepo.getMusicList(id);
  } catch (e) {
    if (kDebugMode) {
      print("Error getting all music: $e");
    }
    return null;
  }
}


  // get list music meditation chose
  Future<List<MusicsModel>> getMusicMeditate(String idMeditation) async {
    String id = await idTopic.getChoseTopic();
    return musicRepo.getMusicMeditate(idMeditation, id);
  }

  // get list music meditate daily thought
  Future<List<MusicsModel>> getMusicMeditateDailyThought() async {
    String id = await idTopic.getChoseTopic();
    return musicRepo.getMusicMeditateDailyThought(id);
  }

  // get list music meditation chose
  Future<List<MusicsModel>> getMusicSleep(String idSleep) async {
    String id = await idTopic.getChoseTopic();
    return musicRepo.getMusicSleep(idSleep, id);
  }

  // get list music meditation relaxation piano
  Future<List<MusicsModel>> getMusicMeditationRelaxationPiano() async {
    String id = await idTopic.getChoseTopic();
    return await musicRepo.getMusicMeditationRelaxationPiano(id);
  }

  // get list music meditation Relaxation jazz
  Future<List<MusicsModel>> getMusicMeditationRelaxationJazz() async {
    String id = await idTopic.getChoseTopic();
    return await musicRepo.getMusicMeditationRelaxationJazz(id);
  }

  // get list music meditation english podcast male voice
  Future<List<MusicsModel>> getMusicMeditationPodcastMaleVoice() async {
    String id = await idTopic.getChoseTopic();
    List<MusicsModel> list =
        await musicRepo.getMusicMeditationPodcastMaleVoice(id);
    if (list.isEmpty) {
      return [];
    }
    return list;
  }

  // get list music meditation english podcast male voice
  Future<List<MusicsModel>> getMusicMeditationPodcastFemaleVoice() async {
    String id = await idTopic.getChoseTopic();
    List<MusicsModel> list =
        await musicRepo.getMusicMeditationPodcastFemaleVoice(id);
    if (list.isEmpty) {
      return [];
    }
    return list;
  }

  // download music
  Future<void> downloadMusic(String musicUrl, String imageUrl, String id) async {
    final music = await musicRepo.getDetailMusic(id);
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      //
      String imageExtension = getExtension(imageUrl); // Lấy phần mở rộng của ảnh
      String imagePath = '${dir.path}/image$imageExtension'; // Đường dẫn để lưu ảnh
      await dio.download(
        imageUrl,
        imagePath,
        options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
      );
      //
      String musicExtension = getExtension(musicUrl); // Lấy phần mở rộng của tệp nhạc
      String musicPath = '${dir.path}/music$id$musicExtension'; // Đường dẫn để lưu trữ tệp nhạc

      await dio.download(
        musicUrl, 
        musicPath,
        options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
      );
      MusicsModel musicsModel = MusicsModel(
          id: music.id,
          title: music.title,
          author: music.author,
          image: imagePath,
          url: musicPath,
          idTopic: music.idTopic,
          idSleep: music.idSleep,
          idMeditation: music.idMeditation,
          meditation: music.meditation,
          genres: music.genres);
      addMusicToList(musicsModel);
      // Hoàn thành việc tải xuống và lưu trữ
      if (kDebugMode) {
        print('Image đã được tải xuống và lưu trữ tại: $imagePath');
        print('Nhạc đã được tải xuống và lưu trữ tại: $musicPath');
      }
    } catch (e) {
      // Xử lý lỗi
      if (kDebugMode) {
        print('Lỗi khi tải xuống nhạc: $e');
      }
    }
  }

  //
  String getExtension(String url) {
    // Lấy phần mở rộng của ảnh từ URL
    // Ví dụ: '.jpg', '.png', ...
    Uri uri = Uri.parse(url);
    return uri.pathSegments.lastWhere(
      (segment) => segment.contains('.'),
      orElse: () => '',
    );
  }

  void addMusicToList(MusicsModel music) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final musicList = await loadMusicList();
    musicList.add(music);
    final musicListJson = musicList.map((music) => music.toJson()).toList();
    prefs.setString('musicList', jsonEncode(musicListJson));
    // In ra danh sách nhạc đã được lưu
    if (kDebugMode) {
      print('Danh sách nhạc đã được lưu: $musicList');
    }
  }

  // delete a item by list music sharedpreferences
  void removeMusicFromList(String musicId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final musicList = await loadMusicList();
    musicList.removeWhere((music) => music.id == musicId);
    final musicListJson = musicList.map((music) => music.toJson()).toList();
    prefs.setString('musicList', jsonEncode(musicListJson));
    // In ra danh sách nhạc đã được lưu sau khi xoá
    if (kDebugMode) {
      print('Danh sách nhạc đã được lưu sau khi xoá: $musicList');
    }
  }

  // load list music download by sharedpreferances
  Future<List<MusicsModel>> loadMusicList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final musicListJson = prefs.getString('musicList');
    if (musicListJson != null) {
      final savedList = jsonDecode(musicListJson) as List<dynamic>;
      final loadedList =
          savedList.map((item) => MusicsModel.fromJson(item)).toList();
      return loadedList;
    } else {
      return [];
    }
  }
}
