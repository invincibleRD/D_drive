import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app_2/controllers/files_screen_controller.dart';
import 'package:my_app_2/utils.dart';
class RecentFiles extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Recent Files", 
            style: textStyle(20, textColor, FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        GetX(
          builder: (FilesScreenController controller) {
            return SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: controller.recentfilesList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 14,left: 1),
                    child: SizedBox(
                      height: 65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.recentfilesList[index].fileType == "image" ? ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child:  Image(
                              width: 65,
                              height: 60,
                              image: NetworkImage(
                                controller.recentfilesList[index].url
                              ),
                              fit: BoxFit.cover,
                            ),
                          ) : Container(
                            width: 65,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color:Colors.grey,width: 0.15),
                              borderRadius: BorderRadius.circular(14)
                             ),
                             child: Center(
                              child: Image(
                                width: 42,
                                height: 42,
                                image: AssetImage('images/${controller.recentfilesList[index].fileExtension}.png'),
                              ),
                             ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            controller.recentfilesList[index].name, 
                            style: textStyle(13, textColor, FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        )
      ],
    );
  }
}