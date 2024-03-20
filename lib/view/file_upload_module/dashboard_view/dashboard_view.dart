import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tem_assessment_firebase/controllers/dashboard_controller.dart';
import 'package:tem_assessment_firebase/view/file_upload_module/dashboard_view/widgets/image_view_widget.dart';
import 'package:tem_assessment_firebase/view/file_upload_module/dashboard_view/widgets/video_vidget.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<DashBoardController>().getFileFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardController>(builder: (context, controller, _) {
      return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.pickFileFromGallery(context);
            },
            child: Icon(Icons.upload),
          ),
          backgroundColor: Color(0xFFf5eded),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Upload',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 25,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            hintText: 'Search',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.totalList != null
                        ? controller.totalList.length
                        : 0,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return controller.totalList == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : InkWell(
                              onTap: () {
                                if (controller.totalList[index]['type'] ==
                                    'Video') {
                                  showDialog(
                                    context: context,
                                    builder: (_) => VideoPlayerWidget(
                                        videoUrl: controller.totalList[index]
                                            ['file']),
                                  );
                                } else if (controller.totalList[index]
                                        ['type'] ==
                                    'Image') {
                                  showDialog(
                                    context: context,
                                    builder: (_) => ImageDialog(
                                        fileUrl: controller.totalList[index]
                                            ['file']),
                                  );
                                } else {
                                  controller.launchURL(
                                      controller.totalList[index]['file']);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: controller.totalList[index]
                                                              ['type'] ==
                                                          'Image'
                                                      ? NetworkImage(controller
                                                                  .totalList[index]
                                                              ['file'])
                                                          as ImageProvider<
                                                              Object>
                                                      : controller.totalList[index]
                                                                  ['type'] ==
                                                              'Video'
                                                          ? AssetImage(
                                                              'images/video.png')
                                                          : controller.totalList[index]
                                                                      ['type'] ==
                                                                  'PDF'
                                                              ? AssetImage('images/pdf.png')
                                                              : controller.totalList[index]['type'] == 'Word'
                                                                  ? AssetImage('images/word.png')
                                                                  : AssetImage('images/doc.jpg')),
                                            ),
                                          )
                                          // : controller.totalList[index]
                                          //             ['type'] ==
                                          //         'Video'
                                          //     ? Container(
                                          //         decoration: BoxDecoration(
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   5),
                                          //         ),
                                          //         height: 200,
                                          //         child: VideoPlayerWidget(
                                          //             videoUrl: controller
                                          //                     .totalList[index]
                                          //                 ['file']),
                                          //       )
                                          //     : Container(),
                                        ],
                                      ),
                                    ]),
                              ));
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
