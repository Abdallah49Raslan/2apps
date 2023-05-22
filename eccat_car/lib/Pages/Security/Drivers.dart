import 'dart:io';
import 'package:eccat_car/core/colors.dart';
import 'package:eccat_car/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../widget/text_fild.dart';

class DriversPage extends StatefulWidget {
  @override
  _DriversPageState createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final picker = ImagePicker();

  File? _image;
  String? _uploadedImageUrl;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  Future<void> _selectAndUploadImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      final Reference storageRef =
          storage.ref().child('driver_images').child(DateTime.now().toString());

      final UploadTask uploadTask = storageRef.putFile(_image!);

      final TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {});

      final String downloadUrl = await storageSnapshot.ref.getDownloadURL();

      setState(() {
        _uploadedImageUrl = downloadUrl;
      });
    }
  }

  Future<void> _addDriver() async {
    if (_uploadedImageUrl != null) {
      String driverName = _nameController.text;
      int age = int.tryParse(_ageController.text) ?? 0;

      CollectionReference driversCollection = firestore.collection('drivers');
      if ((await driversCollection.get()).docs.isEmpty) {
        // Create the "drivers" collection if it doesn't exist
        await driversCollection.doc();
      }

      await driversCollection.add({
        'driverName': driverName,
        'age': age,
        'profilePicture': _uploadedImageUrl,
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColorDark,
        title: const Text(
          "Drivers",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: whiteText,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _selectAndUploadImage,
              child: Text(
                'Select Image',
                style: headline2,
              ),
            ),
            if (_image != null) Image.file(_image!),
            textField(
              controller: _nameController,
              hintTxt: 'Driver Name',
            ),
            textField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              hintTxt: 'Age',
            ),
            ElevatedButton(
              onPressed: _addDriver,
              child: Text(
                'Add Driver',
                style: headline2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
