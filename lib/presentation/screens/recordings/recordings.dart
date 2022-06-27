import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_student/presentation/route.dart';
import 'package:folldy_student/presentation/screens/recording_screen/recording_screen.dart';
import 'package:folldy_student/presentation/screens/recordings/recordings_controller.dart';
import 'package:folldy_student/utils/snackbar_utils.dart';

class Recordings extends StatelessWidget {
  const Recordings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RecordingsController recordingsController = RecordingsController();
    recordingsController.getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recordings"),
      ),
      body: AnimatedBuilder(
          animation: recordingsController,
          builder: (context, child) {
            return NetworkResource(
                error: recordingsController.appError,
                isLoading: recordingsController.isLoading,
                child: ListView.builder(
                    itemCount: recordingsController.recordings.length,
                    itemBuilder: ((context, index) =>
                        Builder(builder: (context) {
                          Map<String, dynamic> presentation =
                              recordingsController.recordings[index];
                          // List timeLine = presentation["audio"][0]["timeLine"];
                          return ListTile(
                            title: Text(presentation["presentation"]),
                            onTap: () => Get.toNamed(AppRoute.recordingScreen,
                                arguments: PresentationScreenArguments(
                                    presentationId: presentation["id"],
                                    thumbnail: presentation["thumbnail"]
                                        ["portrait"])),
                            trailing: PopupMenuButton<PopupOptions>(
                                itemBuilder: ((context) => PopupOptions.values
                                    .map((e) => PopupMenuItem(
                                        value: e, child: Text(e.title)))
                                    .toList()),
                                onSelected: (e) => recordingsController
                                    .handlePopupMenu(e, presentation)),
                          );
                        }))));
          }),
    );
  }
}
