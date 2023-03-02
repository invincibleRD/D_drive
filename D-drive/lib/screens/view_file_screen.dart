import 'package:flutter/material.dart';
import 'package:my_app_2/models/file_model.dart';
import 'package:my_app_2/utils.dart';
import 'package:my_app_2/widgets/audio_player_widget.dart';
import 'package:my_app_2/widgets/video_player_widget.dart';

import '../widgets/pdf_viewer.dart';

class ViewFileScreen extends StatelessWidget {
  FileModel file;
  ViewFileScreen(this.file);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            file.name,
            style: textStyle(18, Colors.white, FontWeight.w600),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15))),
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                file.name,
                                style: textStyle(
                                    16, Colors.black, FontWeight.w500),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 3,
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.file_download,
                              color: Colors.grey,
                            ),
                            dense: true,
                            contentPadding: const EdgeInsets.only(
                                bottom: 0, left: 16, top: 12),
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Text(
                              "Download",
                              style:
                                  textStyle(16, Colors.black, FontWeight.w600),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.delete_forever,
                              color: Colors.grey,
                            ),
                            dense: true,
                            contentPadding: const EdgeInsets.only(
                                bottom: 12, left: 16, top: 8),
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            title: Text(
                              "Remove",
                              style:
                                  textStyle(16, Colors.black, FontWeight.w600),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.more_vert))
          ],
        ),
      ),
      body: file.fileType == "image"
          ? showImage(file.url)
          : file.fileType == "application"
              ? showFile(file, context)
              : file.fileType == "video" 
                  ? VideoPlayerWidget(file.url) 
                  : file.fileType == "audio" 
                    ? AudioPlayerWidget(file.url)
                    :showError(), 
    );
  }
}
showError(){

}

showImage(String url) {
  return Center(
    child: Image(image: NetworkImage(url)),
  );
}

showFile(FileModel file, context) {
  if (file.fileExtension == 'pdf') {
    return PdfViewer(file);
  } else {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Unfortunately this file cannot be opened",
            style: textStyle(18, Colors.white, FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Try Downloading file",
            style: textStyle(18, Colors.white, FontWeight.w300),
          ),
           const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 36,
            child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                ),
                child: Center(
                  child: Text(
                    "Download",
                    style: textStyle(17, Colors.white, FontWeight.w600),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
