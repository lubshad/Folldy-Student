import 'dart:convert';
import 'dart:io';

import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_student/data/core/api_constants.dart';
import 'package:folldy_student/presentation/screens/recording_screen/audio_player_mixin.dart';
import 'package:folldy_student/presentation/screens/recording_screen/page_navigation_mixin.dart';
import 'package:folldy_student/presentation/screens/recording_screen/recording_mixin.dart';
import 'package:folldy_student/presentation/screens/recording_screen/recording_screen.dart';
import 'package:folldy_student/utils/extensions.dart';
import 'package:folldy_utils/domain/usecase/get_all_pages.dart';
import 'package:folldy_utils/domain/usecase/upload_presentation_audio.dart';
import 'package:folldy_utils/presentation/elements/element_type.dart';
import 'package:folldy_utils/presentation/elements/read_mode_element.dart';

import '../login_screen/auth_controller.dart';

class RecordingController extends ChangeNotifier
    with
        RecordingMixin,
        PageNavigationMixin,
        AudioPlayerMixin,
        WidgetsBindingObserver {
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      audioPlayer.playing ? audioPlayer.pause() : null;
      pauseRecording();
    }
  }

  final PresentationScreenArguments presentationScreenArguments;
  RecordingController(this.presentationScreenArguments) {
    WidgetsBinding.instance.addObserver(this);
    presentationDetails["pages"] = [presentationScreenArguments.thumbnail];
  }

  CacheManager cacheManager = Get.find();

  bool showPlayer = false;

  UploadPresentationAudio uploadPresentationAudio =
      UploadPresentationAudio(Get.find());

  // String? outputPath;

  GetAllPages getallPages = GetAllPages(Get.find());

  List get pages => presentationDetails["pages"] ?? [];
  List<ReadModeElement> get readmodeElements =>
      ReadModeElement.fromList(presentationDetails["readmodeElements"]);

  Map<String, dynamic> presentationDetails = {
    "pages": [],
    "audios": [],
    "readmodeElements": []
  };

  AppError? appError;
  bool isLoading = true;
  makeLoading() {
    isLoading = true;
    notifyListeners();
  }

  makeNotLoading() {
    isLoading = false;
    notifyListeners();
  }

  retry() async {
    appError = null;
    makeLoading();
    getData();
  }

  getData() async {
    final response = await getallPages(
        GetAllPagesArguments(presentationScreenArguments.presentationId));
    response.fold((l) {
      l.handleError();
      makeNotLoading();
    }, (r) => handleResponse(r));
  }

  void stopRecordingAndShowPlaybutton() async {
    String? outputPath = await stopRecording();
    audioPlayer.setFilePath(outputPath!);
    uploadAudio(outputPath: outputPath);
  }

  uploadAudio({required String outputPath, int? id}) async {
    showPlayer = true;
    notifyListeners();
    List<MultipartFile> mulitpartFiles = [];
    if (id != null) {
      final multipartFile = await MultipartFile.fromPath("audio", outputPath);
      mulitpartFiles.add(multipartFile);
    }
    Map<String, dynamic> data = {
      "presentation_id": presentationScreenArguments.presentationId,
      "faculty": Get.find<AuthController>().faculty!.id,
      "timeLine": json.encode(pageNavigationTimeLine),
      "localPath": outputPath
    };
    if (id != null) {
      data["id"] = id;
    }
    final response = await uploadPresentationAudio(
        UploadFileParams(data, mulitpartFiles, ApiConstants.uploadAudio));
    response.fold((l) => l.handleError(), (r) {
      if (r["status"] != 1) return;
      final savedId = r["audios"].isEmpty ? null : r["audios"][0]["id"];
      if (savedId == null) return;
      if (r["audios"][0]["audio"] == null) {
        uploadAudio(outputPath: outputPath, id: savedId);
      }
    });
  }

  handleResponse(r) async {
    presentationDetails = r;
    if (presentationDetails["audios"].isNotEmpty) {
      final remoteAudio = presentationDetails["audios"][0]["audio"];
      final localAudio = presentationDetails["audios"][0]["localPath"];
      final id = presentationDetails["audios"][0]["id"];
      if (remoteAudio == null) {
        await audioPlayer.setFilePath(localAudio);
        bool fileExists = await File(localAudio).exists();
        if (fileExists) {
          uploadAudio(outputPath: localAudio, id: id);
        }
      } else {
        String remoteUrl = "${ApiConstants.domainMediaUrl}$remoteAudio";
        final cachedFile = await cacheManager.getFileFromCache(remoteUrl);
        if (cachedFile == null) {
          await audioPlayer.setUrl(remoteUrl);
          cacheManager.downloadFile(remoteUrl, key: remoteUrl).then(
              (value) => logger.info("file downloaded ${value.originalUrl}"));
        } else {
          await audioPlayer.setFilePath(cachedFile.file.path);
        }
      }
      pageNavigationTimeLine = presentationDetails["audios"][0]["timeLine"];
      pageNavigationTimeLine.sort((a, b) => b["time"].compareTo(a["time"]));
      showPlayer = true;
    }
    makeNotLoading();
  }

  handleOnTap(Map<String, dynamic> item) {
    logger.info(item);
    if (item["onTap"] == null) return;
    if (item["onTap"] == ElementGestureTap.changePage.index) {
      showPlayer ? findPageAndSeekToTimeLine(item) : findPageAndNavigate(item);
    } else if (item["onTap"] == ElementGestureTap.showChild.index) {
      // List<dynamic> items = currentScreen["items"];
      // for (var element in items) {
      //   if (element["parent"] == item["element_uuid"]) {
      //     element["hidden"] = false;
      //     notifyListeners();
      //     return;
      //   }
      // }
    }
  }

  void findPageAndSeekToTimeLine(Map<String, dynamic> item) {
    Map<String, dynamic>? newPage = pages.firstWhereOrNull(
        (element) => element["parent"] == item["element_uuid"]);
    if (newPage == null) return;
    Map<String, dynamic>? timeLineItem =
        pageNavigationTimeLine.firstWhereOrNull(
            (element) => element["page_uuid"] == newPage["element_uuid"]);
    if (timeLineItem == null) return;
    audioPlayer.seek(Duration(milliseconds: timeLineItem["time"]));
  }

  void findPageAndNavigate(Map<String, dynamic> item) {
    var newPage = pages.firstWhereOrNull(
        (element) => element["parent"] == item["element_uuid"]);
    if (newPage == null) return;
    int index = pages.indexOf(newPage);
    navigateToPage(index);
  }

  void nextPage() {
    int nextPageIndex = currentPageIndex + 1;
    if (nextPageIndex < pages.length) {
      navigateToPage(nextPageIndex);
    }
  }

  void recordAction(int value) {
    recordHistory(value);
    recordPageNavigation(value);
  }

  recordPageNavigation(int value) {
    if (stopWath?.elapsed == Duration.zero || showPlayer) return;
    Map<String, dynamic> page = pages[value];
    String pageUuid = page["element_uuid"];
    pageNavigationTimeLine.insert(0, {
      "time": stopWath?.elapsed.inMilliseconds ?? 0,
      "page_uuid": pageUuid,
    });
  }

  Future<void> navigateWithDuration(Duration elapsedDuration) async {
    Map<String, dynamic>? timeLineItem = pageNavigationTimeLine
        .firstWhereOrNull((e) => e["time"] < elapsedDuration.inMilliseconds);
    int pageIndex = 0;
    if (timeLineItem != null) {
      final newPage = pages.firstWhereOrNull(
          (element) => element["element_uuid"] == timeLineItem["page_uuid"]);
      if (newPage != null) {
        pageIndex = pages.indexOf(newPage);
      }
    }
    if (pageIndex != currentPageIndex) {
      navigateToPage(pageIndex);
    }
  }

  Future<bool> pauseAndPop() async {
    // if (audioPlayer.playing) await audioPlayer.pause();
    await audioPlayer.dispose();
    // await pauseRecording();
    await record.dispose();
    return true;
  }
}
