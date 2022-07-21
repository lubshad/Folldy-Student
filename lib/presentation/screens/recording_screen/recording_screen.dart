import 'package:flutter/material.dart';
import 'package:folldy_student/data/core/api_constants.dart';
import 'package:folldy_student/presentation/screens/recording_screen/recording_controller.dart';
import 'package:folldy_student/utils/constants.dart';
import 'package:folldy_utils/data/models/player_state.dart';
import 'package:folldy_utils/presentation/components/player_controlls.dart';
import 'package:folldy_utils/presentation/elements/element_utils.dart';

import 'components/recording_screen_app_bar.dart';

class PresentationScreenArguments {
  final int presentationId;
  final Map<String, dynamic> thumbnail;

  PresentationScreenArguments(
      {required this.presentationId, required this.thumbnail});
}

class RecordingScreen extends StatelessWidget {
  const RecordingScreen({Key? key, required this.presentationScreenArguments})
      : super(key: key);

  final PresentationScreenArguments presentationScreenArguments;

  @override
  Widget build(BuildContext context) {
    RecordingController recordingController =
        RecordingController(presentationScreenArguments);
    recordingController.getData();
    return WillPopScope(
      onWillPop: recordingController.pauseAndPop,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
                animation: recordingController,
                builder: (context, child) {
                  return PageView(
                    onPageChanged: recordingController.recordAction,
                    controller: recordingController.pageController,
                    children: recordingController.pages
                        .map((page) => FittedBox(
                              fit: BoxFit.fill,
                              child: PresentationItem(
                                  previousPage:
                                      recordingController.previousPage,
                                  nextPage: recordingController.nextPage,
                                  item: page,
                                  domainUrl: ApiConstants.domainMediaUrl,
                                  onTap: (item) =>
                                      recordingController.handleOnTap(item)),
                            ))
                        .toList(),
                  );
                }),
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: RecordingScreenAppBar(
                  recordingController: recordingController,
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: defaultPadding,
              child: AnimatedBuilder(
                  animation: recordingController,
                  // child: StreamBuilder<RecordingState>(
                  //     stream: recordingController.recordingStateStream,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         final recordingState = snapshot.data!;
                  //         return RecordingControlls(
                  //           recordingState: recordingState,
                  //           pauseRecording: recordingController.pauseRecording,
                  //           resumeRecording:
                  //               recordingController.resumeRecording,
                  //           startRecording: recordingController.startRecording,
                  //           stopRecording: recordingController
                  //               .stopRecordingAndShowPlaybutton,
                  //         );
                  //       } else {
                  //         return Container();
                  //       }
                  //     }),
                  builder: (context, child) => recordingController.isLoading
                      ? Container()
                      : recordingController.pages.isEmpty
                          ? Container()
                          : !recordingController.showPlayer
                              ? Container()
                              : StreamBuilder<AudioPlayerState>(
                                  stream: recordingController.combinedStream,
                                  builder: (context, snapshot) {
                                    AudioPlayerState playerState =
                                        snapshot.data ??
                                            AudioPlayerState(
                                                playbackSpeed: PlaybackSpeed.x1,
                                                totalDuration: Duration.zero,
                                                elapsedDuration: Duration.zero,
                                                isPlaying: false);
                                    recordingController.navigateWithDuration(
                                        playerState.elapsedDuration);
                                    return PlayerControlls(
                                        popupButton: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.more_horiz)),
                                        changePlaybackSpeed: recordingController
                                            .audioPlayer.setSpeed,
                                        skipBackward:
                                            recordingController.skipBackward,
                                        skipForward:
                                            recordingController.skipForward,
                                        play: recordingController
                                            .audioPlayer.play,
                                        pause: recordingController
                                            .audioPlayer.pause,
                                        playerState: playerState,
                                        seekToDuration: recordingController
                                            .audioPlayer.seek);
                                  })),
            )
          ],
        ),
      ),
    );
  }
}
