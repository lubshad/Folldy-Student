import 'dart:async';

import 'package:basic_template/basic_template.dart';
import 'package:folldy_utils/data/models/recording_state.dart';
import 'package:record/record.dart';

mixin RecordingMixin {
  StreamController<RecordingState>? streamController;
  Timer? timer;
  Duration streamDuration = const Duration(milliseconds: 100);
  Stopwatch? stopWath;
  bool isRecording = false;
  bool isPaused = false;

  Stream<RecordingState> get recordingStateStream {
    void onListen() {
      stopWath = Stopwatch();
      streamController?.add(RecordingState(
        isVisible: true,
          isProcessing: false,
          isRecording: isRecording,
          isPaused: isPaused,
          recordedDuration: stopWath!.elapsed));
    }

    onCancel() {
      stopWath?.stop();
      stopWath = null;
      streamController?.close();
      streamController = null;
      timer = null;
    }

    streamController = StreamController<RecordingState>(
        onListen: onListen, onResume: onListen, onCancel: onCancel);
    return streamController!.stream;
  }

  final record = Record();

  startRecording() async {
    if (await record.hasPermission()) {
      stopWath?.reset();
      record.start(
        bitRate: 24000,
      ).then((path) {
        logger.info("Recording Started");
        stopWath?.start();
        timer = Timer.periodic(streamDuration, (value) {
          streamController?.add(RecordingState(
            isVisible: true,
              isProcessing: false,
              isRecording: true,
              isPaused: false,
              recordedDuration: stopWath?.elapsed ?? Duration.zero));
        });
      });
    }
  }

  Future<String?> stopRecording() async {
    String? recordedPath = await record.stop();
    logger.info("Recording Stopped");
    stopWath?.stop();
    logger.info(recordedPath);
    timer?.cancel();
    streamController?.add(RecordingState(
      isVisible: true,
        isProcessing: true,
        isRecording: false,
        isPaused: false,
        recordedDuration: stopWath?.elapsed ?? Duration.zero));
    return recordedPath;
  }

  pauseRecording() async {
    final recording = await record.isRecording();
    if (!recording) return;
    await record.pause();
    logger.info("Recording Paused");
    stopWath?.stop();
    timer?.cancel();
    streamController?.add(RecordingState(
      isVisible: true,
        isProcessing: false,
        isRecording: true,
        isPaused: true,
        recordedDuration: stopWath?.elapsed ?? Duration.zero));
  }

  resumeRecording() {
    record.resume().then((path) {
      logger.info("Recording Resumed");
      stopWath?.start();
      timer = Timer.periodic(streamDuration, (timer) {
        streamController?.add(RecordingState(
          isVisible: true,
            isProcessing: false,
            isRecording: true,
            isPaused: false,
            recordedDuration: stopWath?.elapsed ?? Duration.zero));
      });
    });
  }
}
