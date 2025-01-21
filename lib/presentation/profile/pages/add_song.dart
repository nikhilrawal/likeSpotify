import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';

class AddSongScreen extends StatefulWidget {
  const AddSongScreen({Key? key}) : super(key: key);
  @override
  _AddSongScreenState createState() => _AddSongScreenState();
}

class _AddSongScreenState extends State<AddSongScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _artistNameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  File? _coverImage;
  File? _songFile;

  bool _isLoading = false;

  Future<void> _pickCoverImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _coverImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickSongFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result != null) {
      setState(() {
        _songFile = File(result.files.single.path!);
      });
    }
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload suitable mp3 file')),
      );
      return;
    }
  }

  Future<void> _addSong() async {
    print('entered this function');
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Validation failed')),
      );
      return;
    }

    // Check if cover image or song file is null
    if (_coverImage == null || _songFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please upload both a cover image and a song file')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String artistName = _artistNameController.text.trim();
      String songName = _songNameController.text.trim();
      String fileName = '$artistName - $songName';
      double duration = double.parse(_durationController.text.trim());

      // Safely upload cover image to Firebase Storage
      String coverImageUrl = await _uploadFile(
        file: _coverImage!,
        storagePath: 'covers/$fileName.jpg',
      );
      print("Cover image uploaded: $coverImageUrl");

      // Safely upload song file to Firebase Storage
      String songFileUrl = await _uploadFile(
        file: _songFile!,
        storagePath: 'songs/$fileName.mp3', // Song file storage path
      );
      print("Song file uploaded: $songFileUrl");

      // Create a document in Firebase Firestore
      await FirebaseFirestore.instance.collection('songs').add({
        'title': songName,
        'artist': artistName,
        'releaseDate': Timestamp.now(),
        'duration': duration, // Store the URL for the song file
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Song added successfully!')),
      );
      Navigator.pop(context); // Go back to previous screen
    } catch (e) {
      // Print detailed error message for debugging
      print("Error adding song: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add song: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> _uploadFile(
      {required File file, required String storagePath}) async {
    final ref = FirebaseStorage.instance.ref().child(storagePath);
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: SvgPicture.asset(
            AppVectors.spotifylogo, // Replace with your logo or image
            height: 40,
            width: 40,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0, // Make app bar transparent if you want
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Form(
            key: _formKey, // Assign the form key to the Form widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Song',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 30),

                // Song Name Input
                TextFormField(
                  controller: _songNameController,
                  decoration: InputDecoration(
                    labelText: 'Song Name',
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    filled: true,
                    fillColor: isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the song name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Artist Name Input
                TextFormField(
                  controller: _artistNameController,
                  decoration: InputDecoration(
                    labelText: 'Artist Name',
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    filled: true,
                    fillColor: isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the artist name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Duration Input
                TextFormField(
                  controller: _durationController,
                  decoration: InputDecoration(
                    labelText: 'Duration (like 3.52)',
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    filled: true,
                    fillColor: isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.contains(RegExp(r'[A-Z]')) ||
                        value.contains(RegExp(r'[a-z]'))) {
                      return 'Please enter a valid duration in numeric input';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Cover Image Upload
                Text(
                  'Cover Image (PNG):',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickCoverImage,
                      child: Text(
                        'Upload PNG',
                        style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 20), // Full width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: isDarkMode
                            ? AppColors.darkgrey
                            : Colors.white, // Adjust button color
                      ),
                    ),
                    if (_coverImage != null) ...[
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'Selected: ${_coverImage!.path.split('/').last}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 20),

                // Song File Upload
                Text(
                  'Song File (MP3):',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickSongFile,
                      child: Text(
                        'Upload MP3',
                        style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 20), // Full width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: isDarkMode
                            ? AppColors.darkgrey
                            : Colors.white, // Adjust button color
                      ),
                    ),
                    if (_songFile != null) ...[
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'Selected: ${_songFile!.path.split('/').last}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 20),

                // Loading Indicator or Add Song Button
                if (_isLoading)
                  Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(
                    onPressed: _addSong,
                    child: Text(
                      'Add Song',
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(double.infinity, 50), // Full width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: isDarkMode
                          ? AppColors.darkgrey
                          : Colors.white, // Adjust button color
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
