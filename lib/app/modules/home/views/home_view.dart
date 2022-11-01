import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async => await controller.mergeFiles(),
                  child: const Text("Merge"),
                ),
                GetBuilder<HomeController>(
                  builder: (controller) => controller.videoController != null
                      ? Container(
                          width: 250,
                          height: 250,
                          color: Colors.black,
                          child: VideoPlayer(controller.videoController!),
                        )
                      : const SizedBox.shrink(),
                ),
              ]),
        ),
      ),
      floatingActionButton: GetBuilder<HomeController>(
        builder: (controller) => controller.videoController != null
            ? FloatingActionButton(
                onPressed: controller.videoClicked,
                child: Icon(
                  controller.videoController!.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
