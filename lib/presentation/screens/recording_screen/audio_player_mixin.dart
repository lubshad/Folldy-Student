import 'package:basic_template/basic_template.dart';
import 'package:folldy_utils/data/models/player_state.dart';
import 'package:folldy_utils/folldy_utils.dart';
import 'package:folldy_utils/presentation/components/player_controlls.dart';

mixin AudioPlayerMixin {
  final audioPlayer = AudioPlayer();

  Stream<AudioPlayerState> get combinedStream => CombineLatestStream(
      [audioPlayer.positionStream, audioPlayer.playerStateStream],
      (value) => AudioPlayerState(
            playbackSpeed: audioPlayer.speed.playbackSpeed,
            totalDuration: audioPlayer.duration ?? Duration.zero,
            elapsedDuration: audioPlayer.position,
            isPlaying: audioPlayer.playing,
          ));

  void skipForward() {
    Duration newDuration = audioPlayer.position + const Duration(seconds: 10);
    audioPlayer.seek(newDuration > (audioPlayer.duration ?? Duration.zero)
        ? audioPlayer.duration
        : newDuration);
  }

  void skipBackward() {
    Duration newDuration = audioPlayer.position - const Duration(seconds: 10);
    audioPlayer.seek(newDuration.isNegative ? Duration.zero : newDuration);
  }
}
