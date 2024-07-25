import 'dart:io';

import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/models/UIHelper.dart';
import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const CompleteProfile(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  File? imageFile;
  final fullnamecontroller = TextEditingController();
  String? existingImageUrl;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userModel.uid)
        .get();
    if (userDoc.exists) {
      final userData = userDoc.data();
      setState(() {
        fullnamecontroller.text = userData?['fullname'] ?? '';
        existingImageUrl = userData?['profile_picture'];
      });
    }
  }

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20,
    );

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Upload Profile Picture"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  selectImage(ImageSource.gallery);
                },
                leading: const Icon(Icons.photo_album),
                title: const Text("Select from Gallery"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  selectImage(ImageSource.camera);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
              ),
            ],
          ),
        );
      },
    );
  }

  void checkValues() {
    String fullname = fullnamecontroller.text.trim();

    if (fullname == "" || imageFile == null) {
      UIHelper.showAlertDialog(context, "Incomplete Data",
          "Please fill all the fields and upload a profile picture");
    } else {
      uploadData();
    }
  }

  void uploadData() async {
    try {
      UIHelper.showLoadingDialog(context, "Uploading image..");

      UploadTask uploadTask = FirebaseStorage.instance
          .ref("profilepictures")
          .child(widget.userModel.uid.toString())
          .putFile(imageFile!);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      widget.userModel.fullname = fullnamecontroller.text.trim();
      widget.userModel.profilepic = imageUrl;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userModel.uid)
          .set(widget.userModel.toMap())
          .then((value) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return HomePage(
                userModel: widget.userModel, firebaseUser: widget.firebaseUser);
          }),
        );
      });
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog
      UIHelper.showAlertDialog(context, "Error", "Failed to upload image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Complete Profile"),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              const SizedBox(height: 20),
              CupertinoButton(
                onPressed: () {
                  showPhotoOptions();
                },
                padding: EdgeInsets.all(0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!) as ImageProvider<Object>?
                      : (existingImageUrl != null
                          ? NetworkImage(existingImageUrl!)
                              as ImageProvider<Object>?
                          : null),
                  child: (imageFile == null && existingImageUrl == null)
                      ? const Icon(
                          Icons.person,
                          size: 60,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 30),
              MyTextfield(
                controller: fullnamecontroller,
                hintText: "Fullname",
                obscureText: false,
              ),
              const SizedBox(height: 50),
              Container(
                width: 140.0,
                height: 60.0,
                child: CupertinoButton(
                  color: Colors.black,
                  onPressed: () {
                    checkValues(); // Call checkValues instead of uploadData directly
                  },
                  child: const Text(
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
