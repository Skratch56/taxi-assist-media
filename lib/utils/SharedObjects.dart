import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_assist/constants/Constants.dart';

import 'VideoThumbnail.dart';


class SharedObjects {
  static CachedSharedPreferences prefs;
  static File videothumb;
  /*
  Supporting only for android for now
   */
  static downloadFile(String fileUrl, String fileName) async {
    await FlutterDownloader.enqueue(
      url: fileUrl,
      fileName: fileName,
      savedDir: Constants.downloadsDirPath,
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
  }

  static Future<File> getThumbnail(String videoUrl) async {
    Constants.cacheDirPath = (await getTemporaryDirectory()).path;
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: Constants.cacheDirPath,
      imageFormat: ImageFormat.JPEG,
      maxHeightOrWidth: 300,
      quality: 100,
    );
    final file = File(thumbnail);
    return file;
  }
  static Future<File> getThumbnail2(String videoUrl, String filename) async {
    Constants.cacheDirPath = (await getTemporaryDirectory()).path;
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: Constants.cacheDirPath,
      imageFormat: ImageFormat.JPEG,
      maxHeightOrWidth: 300,
      quality: 100,
    );
    final file = File(thumbnail);
    file.rename(filename+'.jpg');
    print('yo '  + file.path);
    print('yo '  + thumbnail.toString());
    videothumb = File(thumbnail);
    return file;
  }



  static int getTypeFromFileType(FileType fileType) {
    if (fileType == FileType.IMAGE)
      return 1;
    else if (fileType == FileType.VIDEO)
      return 2;
    else
      return 3;
  }
}

class CachedSharedPreferences {
  static SharedPreferences sharedPreferences;
  static CachedSharedPreferences instance;
  static final cachedKeyList = {
    Constants.firstRun,
    Constants.sessionUid,
    Constants.sessionUsername,
    Constants.sessionName,
    Constants.sessionProfilePictureUrl,
    Constants.configDarkMode,
    Constants.configMessagePaging,
    Constants.configMessagePeek,
  };
  static final sessionKeyList = {
    Constants.sessionName,
    Constants.sessionUid,
    Constants.sessionUsername,
    Constants.sessionProfilePictureUrl
  };

  static Map<String, dynamic> map = Map();

  static Future<CachedSharedPreferences> getInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(Constants.firstRun) == null ||
        sharedPreferences.get(
            Constants.firstRun)) { // if first run, then set these values
      await sharedPreferences.setBool(Constants.configDarkMode, false);
      await sharedPreferences.setBool(Constants.configMessagePaging, false);
      await sharedPreferences.setBool(Constants.configImageCompression, true);
      await sharedPreferences.setBool(Constants.configMessagePeek, true);
      await sharedPreferences.setBool(Constants.firstRun, false);
    }
    for (String key in cachedKeyList) {
      map[key] = sharedPreferences.get(key);
    }
    if (instance == null) instance = CachedSharedPreferences();
    return instance;
  }

  String getString(String key) {
    if (cachedKeyList.contains(key)) {
      return map[key];
    }
    return sharedPreferences.getString(key);
  }

  bool getBool(String key) {
    if (cachedKeyList.contains(key)) {
      return map[key];
    }
    return sharedPreferences.getBool(key);
  }

  Future<bool> setString(String key, String value) async {
    bool result = await sharedPreferences.setString(key, value);
    if (result)
      map[key] = value;
    return result;
  }

  Future<bool> setBool(String key, bool value) async {
    bool result = await sharedPreferences.setBool(key, value);
    if (result)
      map[key] = value;
    return result;
  }

  Future<void> clearAll() async {
    await sharedPreferences.clear();
    map = Map();
  }

  Future<void> clearSession() async {
    await sharedPreferences.remove(Constants.sessionProfilePictureUrl);
    await sharedPreferences.remove(Constants.sessionUsername);
    await sharedPreferences.remove(Constants.sessionUid);
    await sharedPreferences.remove(Constants.sessionName);
    map.removeWhere((k, v) => (sessionKeyList.contains(k)));
  }
}
