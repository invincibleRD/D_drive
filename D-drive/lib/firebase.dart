import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:my_app_2/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class FirebaseService {
  //only compressing video and images
  Uuid uuid = Uuid();
  Future<File> compressFile(File file, String fileType) async {
    if (fileType == "image") {
      Directory directory = await getTemporaryDirectory();
      String targetpath = directory.path + "/${uuid.v4().substring(0, 8)}.jpg";
      File? result = await FlutterImageCompress.compressAndGetFile(
          file.path, targetpath,
          quality: 75);
      return result!;
    } else if (fileType == "video") {
      MediaInfo? info = await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
        includeAudio: true,
      );
      print(info!.file);
      return File(info.path!);
    } else {
      return file;
    }
  }

  uploadFile(String foldername) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      for (File file in files) {
        // Getting the file type
        String? fileType = lookupMimeType(file.path);
        String end = '/';
        int startIndex = 0;
        int endIndex = fileType!.indexOf(end);
        String filteredFiletype = fileType.substring(startIndex, endIndex);

        // filterring the file name and extension
        String fileName = file.path.split('/').last;
        String fileExtension = fileName.substring(fileName.indexOf('.') + 1);

        // Gettin compressed file
        File compressedfile = await compressFile(file, filteredFiletype);

        // getting length of files collection
        int length = await userCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('files')
            .get()
            .then((value) => value.docs.length);
        
        // Uploading file to firebase storage
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child('files')
            .child('File $length')
            .putFile(compressedfile);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        String fileUrl = await snapshot.ref.getDownloadURL();

        // Saving data in firebase document
        userCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('files')
            .add({
              "fileName" : fileName,
              "fileUrl" : fileUrl,
              "fileType" : filteredFiletype,
              "fileExtension" : fileExtension,
              "folder" : foldername,
              "size" : (compressedfile.readAsBytesSync().lengthInBytes / 1024).round(),
              "dateUploaded" :DateTime.now(),
              
            });
      }
      if (foldername == '') {
        Get.back();
      }
    } else {
      print("Cancelled");
    }
  }
}
