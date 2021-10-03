import 'dart:io';

import 'package:books_app/constants/colors.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/widgets/button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  PickedFile? image;

  String? _name;
  String? _address;
  String? _city;

  String? _state;
  String _imageUrl = '';
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserData>(context);
    final String uID = _authService.getUID;
    final String? image = userProvider.photoURL;
    // final UserData userData = snapshot.data as UserData

    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Edit Your Profile',
                      style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 26),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    width: 300,
                    padding: const EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: _imageUrl == ''
                          ? NetworkImage(userProvider.photoURL!)
                          : NetworkImage(_imageUrl),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.photo_camera, size: 30),
                        onPressed: () async {
                          final String? imageFromFirebase =
                              await uploadImageCamera(uID);
                          setState(() {
                            _imageUrl = imageFromFirebase!;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.photo_library, size: 30),
                        onPressed: () async {
                          final String imageFromFirebase =
                              await uploadImageGallery(uID);
                          setState(() {
                            _imageUrl = imageFromFirebase;
                          });
                        },
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Your Name',
                              labelText: 'Enter your name'),
                          // initialValue: userData.displayName,
                          validator: (String? val) =>
                              val!.isEmpty ? 'Please enter a name' : null,
                          onSaved: (String? value) {
                            setState(() {
                              _name = value;
                            });
                          },
                          onChanged: (String v) {
                            _name = v;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Pune', labelText: 'Enter your City'),
                          initialValue: _address,
                          validator: (String? val) =>
                              val!.isEmpty ? 'Please enter a value' : null,
                          onSaved: (String? value) {
                            setState(() {
                              _city = value;
                            });
                          },
                          onChanged: (String v) {
                            _city = v;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Maharashtra',
                              labelText: 'Enter your State'),
                          // initialValue: userData.state,
                          validator: (String? val) =>
                              val!.isEmpty ? 'Please enter a value' : null,
                          onSaved: (String? value) {
                            setState(() {
                              _state = value;
                            });
                          },
                          onChanged: (String v) {
                            _state = v;
                            print(_state);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.black54,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Button(
                    color: greenButton,
                    name: 'Update',
                    myFunction: () async {
                      if (_formKey.currentState!.validate()) {
                        print(_name);
                        print(_city);
                        print(_state);
                        if (_imageUrl == '') {
                          print(userProvider.photoURL);
                        } else {
                          print(_imageUrl);
                        }
                        // await DatabaseService(uid: uID).updateUser(
                        //     _name ?? userData.displayName,
                        //     _city ?? userData.city,
                        //     _state ?? userData.state,
                        //     _imageUrl == ''
                        //         ? userData.photoURL
                        //         : _imageUrl);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future loadAdressPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _address = _prefs.getString('address');
  }

  Future<String?> uploadImageCamera(String uID) async {
    image = await _imagePicker.getImage(source: ImageSource.camera);
    final File file = File(image!.path);
    if (image != null) {
      // Provider.of<UserModel>(context, listen: false)
      //     .updateAvatar();
      final TaskSnapshot snapshot =
          await _firebaseStorage.ref().child('images/$uID').putFile(file);
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }
    return null;
  }

  Future<String> uploadImageGallery(String uID) async {
    image = await _imagePicker.getImage(source: ImageSource.gallery);
    final File file = File(image!.path);
    print(file.toString());
    print('${file.uri}is the fileeeeeee');
    if (image != null) {
      print('${image!.path} has firebase imageeeeeeeee.');

      final TaskSnapshot snapshot =
          await _firebaseStorage.ref().child('images/$uID').putFile(file);
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      // Provider.of<UserModel>(context, listen: false).updateAvatar(file);
      //PROFILE_PIC_ROUTE + file.toString()
      return downloadUrl;
    } else
      return 'No Image displayed';
  }
}
