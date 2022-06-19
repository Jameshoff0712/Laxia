import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:image_picker/image_picker.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  // List<XFile>? _imageFileList;

  // set _imageFile(XFile? value) {
  //   _imageFileList = value == null ? null : <XFile>[value];
  // }

  // Future<void> _onImageButtonPressed(ImageSource source,
  //     {BuildContext? context, bool isMultiImage = false}) async {
  //   if (_controller != null) {
  //     await _controller!.setVolume(0.0);
  //   }
  //   if (isVideo) {
  //     final XFile? file = await _picker.pickVideo(
  //         source: source, maxDuration: const Duration(seconds: 10));
  //     await _playVideo(file);
  //   } else if (isMultiImage) {
  //     await _displayPickImageDialog(context!,
  //         (double? maxWidth, double? maxHeight, int? quality) async {
  //       try {
  //         final List<XFile>? pickedFileList = await _picker.pickMultiImage(
  //           maxWidth: maxWidth,
  //           maxHeight: maxHeight,
  //           imageQuality: quality,
  //         );
  //         setState(() {
  //           _imageFileList = pickedFileList;
  //         });
  //       } catch (e) {
  //         setState(() {
  //           _pickImageError = e;
  //         });
  //       }
  //     });
  //   } else {
  //     await _displayPickImageDialog(context!,
  //         (double? maxWidth, double? maxHeight, int? quality) async {
  //       try {
  //         final XFile? pickedFile = await _picker.pickImage(
  //           source: source,
  //           maxWidth: maxWidth,
  //           maxHeight: maxHeight,
  //           imageQuality: quality,
  //         );
  //         setState(() {
  //           _imageFile = pickedFile;
  //         });
  //       } catch (e) {
  //         setState(() {
  //           _pickImageError = e;
  //         });
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            GestureDetector(
              //onTap: () => context.getImageFromGallery(),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/photo.svg",
                      width: 36,
                      height: 36,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:
                          Text('写真を追加', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 9),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //PhotoCarouselWidget(offerList: _con.offers, heroTag: 'offer_trending_carousel'),
                    // PhotoCarouselWidget(),
                    // PhotoCarouselWidget(),
                    // PhotoCarouselWidget(),
                    // PhotoCarouselWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
