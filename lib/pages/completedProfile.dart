import 'dart:io';

import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  late File? imageFile;
  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    File? croppedImage = await ImageCropper().cropImage(sourcePath: filepath);
    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: ((context) {
          return const AlertDialog(
              title: const Text("Upload Profile Picture"),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                ListTile(
                  onTap: () {
                    selectImage(ImageSource.gallery);
                  },
                  leading: Icon(Icons.photo_album),
                  title: Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    selectImage(ImageSource.camera);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text("Take a Photo"),
                )
              ]));
        }));
  }

  final fullnamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Complete Profile"),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                onPressed: () {
                  showPhotoOptions();
                },
                padding: EdgeInsets.all(0),
                child: CircleAvatar(
                  radius: 60,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MyTextfield(
                controller: fullnamecontroller,
                hintText: "Fullname",
                obscureText: false,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 140.0, // Adjust the width as needed
                height: 60.0, // Adjust the height as needed
                child: CupertinoButton(
                  color: Colors.black,
                  onPressed: () {},
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
