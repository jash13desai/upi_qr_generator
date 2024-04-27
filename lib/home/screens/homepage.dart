import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:upi_qr_generator/home/widgets/qr_widget.dart';
import 'package:upi_qr_generator/home/widgets/cred_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool flag = false;
Widget? qrWidget;

TextEditingController upiTextController = TextEditingController();
TextEditingController nameTextController = TextEditingController();
String? upiID;
String? fullName;

ScreenshotController screenshotController = ScreenshotController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("Generate QR Code"),
        ),
        elevation: 20,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: upiTextController,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                ),
                validator: (val) => val!.isEmpty ? 'Enter UPI ID' : null,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  hintText: "Enter UPI ID",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: nameTextController,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  hintText: "Enter Full Name (as per bank)",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    borderSide: BorderSide(
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              CredButton(
                buttonText: 'Generate UPI QR',
                plunkColor: Colors.teal,
                shimmer: true,
                onTap: () {
                  setState(() {
                    flag = true;
                    upiID = upiTextController.text;
                    fullName = nameTextController.text;
                  });
                  upiTextController.clear();
                  nameTextController.clear();
                },
              ),
              const SizedBox(height: 35),
              flag
                  ? QR(
                      upiID: upiID,
                      fullName: fullName,
                      size: 550,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 25),
              flag
                  ? CredButton(
                      onTap: () async {
                        // _saveToGallery(context);
                        print("save to gallery - initiated!");
                        final qrImage = QR(
                          upiID: upiID,
                          fullName: fullName,
                          size: 550,
                        );
                        await screenshotController
                            .captureFromWidget(
                          InheritedTheme.captureAll(context, qrImage),
                          delay: const Duration(milliseconds: 500),
                        )
                            .then(
                          (image) async {
                            // bool flag = await _saveLocalImage(capturedImage);
                            // await ImageGallerySaver.saveImage(
                            //   capturedImage,
                            // );
                            // if (flag) {
                            //   const SnackBar(
                            //     content: Text("Saved to Gallery!"),
                            //   );
                            // } else {}
                            if (image != null) {
                              final directory =
                                  await getApplicationDocumentsDirectory();
                              final imagePath =
                                  await File('${directory.path}/image.png')
                                      .create();
                              await imagePath.writeAsBytes(image);

                              /// Share Plugin
                              // await Share.shareFiles([imagePath.path]);
                            }
                          },
                        );
                      },
                      buttonText: 'Save to Gallery',
                      plunkColor: const Color.fromARGB(255, 200, 62, 227),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Function()?> _saveToGallery(BuildContext ctx) async {
  print("save to gallery - initiated!");
  final qrImage = QR(
    upiID: upiID,
    fullName: fullName,
    size: 550,
  );
  await screenshotController
      .captureFromWidget(
    InheritedTheme.captureAll(ctx, qrImage),
    delay: const Duration(milliseconds: 500),
  )
      .then(
    (capturedImage) async {
      bool flag = await _saveLocalImage(capturedImage);
      if (flag) {
        // popupDialog(
        //   ctx,
        //   info:
        //       "Check your 'Photo Library' or instantly share the content on your socials by simply clicking 'Share'. (The direct link will be copied to clipboard.)",
        //   buttonText: "Share",
        //   onTap: () {},
        // );
        // Navigator.pop();
        const SnackBar(
          content: Text("Saved to Gallery!"),
        );
      } else {}
    },
  );
  // return null;
}

Future<bool> _saveLocalImage(Uint8List capturedImage) async {
  final result = await ImageGallerySaver.saveImage(
    capturedImage,
  );
  return (result["isSuccess"]);
}
