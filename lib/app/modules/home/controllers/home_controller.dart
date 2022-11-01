import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  // late File silentVideoFile;
  // late File videoWithSoundFile;
  String? videoWithSoundUrlName;
  String? silentVideoUrlName;
  // String? outputUrlName;
  VideoPlayerController? videoController;
  String? outputUrl;
  // String? m3u8OutputUrl;
  String? videoOutputPath;
  String? audioOutputUrl;
  // ChewieController? chewieController;

  @override
  Future<void> onInit() async {
    super.onInit();
    silentVideoUrlName =
        "https://customer-g4g57oh0sv2xwkrm.cloudflarestream.com/ac91cdc39e594ca1a3c12385f1a94ca3/manifest/stream_t73c916defd02d28c56fa830f8102b2a5_r242682183.m3u8";
    videoWithSoundUrlName =
        "https://customer-g4g57oh0sv2xwkrm.cloudflarestream.com/ac91cdc39e594ca1a3c12385f1a94ca3/manifest/stream_t0cf6e2a064415f7baa9936e361d6e0de_r242682180.m3u8";
    await getAppDiretory();
  }

  Future<void> getAppDiretory() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    outputUrl = "${appDocDir.path}/mariam.mp4";
    videoOutputPath = "${appDocDir.path}/output.mp4";
    audioOutputUrl = "${appDocDir.path}/sound_output.mp4";
  }

  void videoClicked() {
    if (videoController != null) {
      videoController!.value.isPlaying
          ? videoController?.pause()
          : videoController?.play();
    }
  }

  Future<void> _audio() async {
    String commandToExecute = "-i $videoWithSoundUrlName -c copy $audioOutputUrl";
    await FFmpegKit.execute(commandToExecute);
  }

  Future<void> _video() async {
    String commandToExecute = "-i $silentVideoUrlName -c copy $videoOutputPath";

    await FFmpegKit.execute(commandToExecute);
  }

  Future<void> mergeFiles() async {
   await _audio();
   await _video();
    String mergeAudioWithVideoCommand =
        '-i $audioOutputUrl -i $videoOutputPath -c copy $outputUrl';
    await FFmpegKit.execute(mergeAudioWithVideoCommand);

    videoController = VideoPlayerController.file(File(outputUrl!))
      ..initialize().then((_) {});
    update();
  }
}
