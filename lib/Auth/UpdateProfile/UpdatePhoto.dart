import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wghsoga_app/Auth/UpdateProfile/UpdateInterests.dart';
import 'package:wghsoga_app/Components/photo/select_photo_options_screen.dart';
import 'package:wghsoga_app/constants.dart';

class UpdatePhoto extends StatefulWidget {
  final data;
  final update_data;
  const UpdatePhoto({super.key, required this.data, required this.update_data});

  @override
  State<UpdatePhoto> createState() => _UpdatePhotoState();
}

class _UpdatePhotoState extends State<UpdatePhoto> {
  //File? _image;
  final List<File> _imageFiles = [];

  @override
  void initState() {
    print(widget.update_data);

    super.initState();
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/wes_back.png'),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: wesGreen,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 2,
                            offset: const Offset(2, 4), // Shadow position
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: wesYellow,
                        ),
                      ),
                    ),
                  ),
                  const Image(
                      height: 50,
                      image: AssetImage('assets/images/geyhey_logo.png'))
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome',
                          style: TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 28,
                              fontFamily: 'Montserrat'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.data['first_name'],
                          style: const TextStyle(
                              height: 1,
                              color: wesWhite,
                              fontSize: 62,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'This is your chance to make your profile dazzle!',
                          style: TextStyle(
                              height: 1.2,
                              color: wesWhite,
                              fontSize: 20,
                              fontFamily: 'Montserrat'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 400,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                                //color: Colors.red
                                ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        //: Colors.red
                                        ),
                                    child: InkWell(
                                      onTap: () {
                                        _showSelectPhotoOptions(context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 4, color: wesYellow),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                        //color: Colors.green
                                        ),
                                    child: Column(
                                      children: [
                                        if (_imageFiles.isNotEmpty) ...[
                                          Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        _imageFiles[0]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  color: Colors.white
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () =>
                                                      _removeImage(0),
                                                ),
                                              )),
                                        ] else ...[
                                          Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ],
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        if (_imageFiles.length > 1) ...[
                                          Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        _imageFiles[1]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  color: Colors.white
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () =>
                                                      _removeImage(1),
                                                ),
                                              )),
                                        ] else ...[
                                          Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      if (_imageFiles.length > 2) ...[
                                        Expanded(
                                          child: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        _imageFiles[2]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  color: Colors.white
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () =>
                                                      _removeImage(2),
                                                ),
                                              )),
                                        ),
                                      ] else ...[
                                        Expanded(
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      if (_imageFiles.length > 3) ...[
                                        Expanded(
                                          child: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        _imageFiles[3]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  color: Colors.white
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () =>
                                                      _removeImage(3),
                                                ),
                                              )),
                                        ),
                                      ] else ...[
                                        Expanded(
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      if (_imageFiles.length > 4) ...[
                                        Expanded(
                                          child: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                        _imageFiles[4]),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  color: Colors.white
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () =>
                                                      _removeImage(4),
                                                ),
                                              )),
                                        ),
                                      ] else ...[
                                        Expanded(
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateInterests(
                            data: widget.data,
                            update_data: widget.update_data,
                          )),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: const Center(
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 15, color: wesWhite),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (_imageFiles.isNotEmpty) {
                  print(_imageFiles);
                  Map<String, dynamic> update_data = {
                    'bio': widget.update_data['bio'],
                    'photos': _imageFiles
                  };

                  print(update_data);

   
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateInterests(
                              data: widget.data,
                              update_data: update_data,
                            )),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: wesYellow),
                child: const Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 15, color: wesGreen),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) return;

      File img = File(pickedFile.path);

      // Crop the image
      img = (await _cropImage(imageFile: img))!;

      // Add the image to the list
      setState(() {
        _imageFiles
            .add(img); // Assuming _imageFiles is a List<File> in your state
      });

      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }
}
