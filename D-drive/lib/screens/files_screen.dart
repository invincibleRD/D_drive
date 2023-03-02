import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_2/controllers/files_screen_controller.dart';
import 'package:my_app_2/firebase.dart';
import 'package:my_app_2/screens/nav_screen.dart';
import 'package:my_app_2/utils.dart';
import '../widgets/folder_section.dart';
import '../widgets/recent_files.dart';


class FilesScreen extends StatelessWidget {
  TextEditingController folderController = TextEditingController();
  FilesScreenController filesScreenController =
    Get.put(FilesScreenController());
    
  openAddFolderDialog(BuildContext context) {
    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.only(right: 15,bottom: 20),
          title: Text(
            "Add new folder",
            style: textStyle(17,Colors.black, FontWeight.w600),
          ),
          content: TextFormField(
            controller: folderController,
            autofocus: true,
            style: textStyle(17, Colors.black, FontWeight.w600),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[250],
              hintText: "Untitiled Folder",
              hintStyle: textStyle(16, Colors.grey, FontWeight.w500)
            ) ,
          ),
          actions: [
            InkWell(
              onTap: () => Get.back(),
              child: Text(
                "Cancel",
                style: textStyle(16, textColor, FontWeight.bold),
                ),
              ),
            InkWell(
              onTap: () { userCollection
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('folders')
                .add({
                  "name": folderController.text,
                  "time": DateTime.now(),
                });
                Get.offAll(NavScreen());
              },
               child: Text(
                "Create",
                style: textStyle(16, textColor, FontWeight.bold),
              ),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecentFiles(),
                  FoldersSection(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom:15),
                child: InkWell(
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      builder : (context) {
                        // ignore: avoid_unnecessary_containers
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25,bottom: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: (() => openAddFolderDialog(context)),
                                  child: Row(
                                    children: [
                                      const Icon(EvaIcons.folderAdd, 
                                      color:Colors.grey,size: 25),
                                      const SizedBox(width: 5,),
                                      Text(
                                        "Folder",
                                        style: textStyle(20, Colors.black, FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () => FirebaseService().uploadFile(''),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      Text(
                                        "Upload",
                                        style: textStyle(20, Colors.black, FontWeight.w600),),
                                        const Icon(EvaIcons.upload, 
                                          color:Colors.grey,size: 25),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } ,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Icon(Icons.add,color: Colors.white,size: 32),
                      // child: Icons(EvaIcons.fileAdd,color: Colors.white,size:32)
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

