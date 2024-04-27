// import 'package:flutter/material.dart';

// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:screenshot/screenshot.dart';
// ScreenshotController screenshotController = ScreenshotController();

// late Widget snapshotWidget;
//                 setState(() {
//                   snapshotWidget = MainWidget(
//                     deviceWidth: appWidth(context),
//                     deviceHeight: appHeight(context),

//                     username: widget.username,
//                     imageLink: widget.imageUrl,
//                     // imageBytes: imageBytes,
//                     isStealth: widget.isStealth,
//                     isPixelated: widget.isPixelated,
//                   );
//                 });
//                 // try{
//                 screenshotController
//                     .captureFromWidget(
//                   InheritedTheme.captureAll(context, snapshotWidget),
//                   delay: const Duration(milliseconds: 500),
//                 )
//                     .then(
//                   (capturedImage) async {
//                     bool flag = await _saveLocalImage(
//                       capturedImage,
//                       widget.username,
//                     );

//                     if (flag) {
//                       setState(() {
//                         isLoading = false;
//                       });
//                       popupDialog(
//                         context,
//                         info:
//                             "Check your 'Photo Library' or instantly share the content on your socials by simply clicking 'Share'. (The direct link will be copied to clipboard.)",
//                         buttonText: "Share",
//                         onTap: () {},
//                       );
//                       Navigator.pop(context);
//                     } else {
//                       log("snapshot unsuccessful!");
//                     }
//                   },
//                 );
