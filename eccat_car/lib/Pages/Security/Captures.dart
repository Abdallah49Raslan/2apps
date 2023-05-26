import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../core/colors.dart';

class Captures extends StatefulWidget {
  const Captures({Key? key}) : super(key: key);

  @override
  State<Captures> createState() => _CapturesState();
}

class _CapturesState extends State<Captures> {
  List<String> imageUrls = []; // List to store the image URLs

  @override
  void initState() {
    super.initState();
    initializeFirebase(); // Initialize Firebase
    fetchImageUrls(); // Fetch image URLs from Firebase Storage
  }

  Future<void> initializeFirebase() async {
    // Initialize Firebase
    await Firebase.initializeApp();
  }

  Future<void> fetchImageUrls() async {
    // Retrieve the list of files from the "/capture" folder in Firebase Storage
    final ListResult result =
        await FirebaseStorage.instance.ref('capture').listAll();

    // Get the download URLs for each file
    for (final Reference ref in result.items) {
      final String downloadUrl = await ref.getDownloadURL();
      setState(() {
        imageUrls.add(downloadUrl); // Add the download URL to the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColorDark,
        title: const Text(
          "Captures",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: whiteText,
          ),
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return imageUrls.isEmpty
                ? Center(
                    child: Text(
                        "No images available"), // Show a message if no images are available
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Image.network(
                      imageUrls[0], // Display the first image URL in the list
                      fit: BoxFit.cover,
                    ),
                  );
          }
        },
      ),
    );
  }
}
