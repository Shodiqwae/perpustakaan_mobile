import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:perpustakaan_mobile/service/modeluser.dart';

class Profile2 extends StatefulWidget {
  final UserModel user;

  Profile2({required this.user});

  @override
  _Profile2State createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  final TextEditingController _accountController = TextEditingController();
  File? _imageFile; // Menyimpan file gambar yang dipilih

  @override
  void initState() {
    super.initState();
    _accountController.text = widget.user.name;
  }

  Future<void> editProfile(BuildContext context) async {
    final String apiUrl = 'http://10.0.2.2:8000/api/editProfile';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['id'] = widget.user.id.toString();
    request.fields['name'] = _accountController.text;

    // Jika ada gambar yang dipilih, tambahkan ke request
    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('gambar', _imageFile!.path));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final updatedUser = UserModel.fromJson(jsonDecode(response.body)['user']);
      print('Profile updated successfully');
      Navigator.pop(context, updatedUser);
    } else {
      print('Failed to update profile: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile, please try again.')),
      );
    }
  }

Future<void> pickImage() async {
try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      // Handle error, show message, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(93, 23, 235, 1),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
           CircleAvatar(
  radius: 150,
  backgroundColor: Colors.transparent,
  child: _imageFile != null
      ? Image.file(_imageFile!, fit: BoxFit.cover)
      : Image.asset('images/bukua.png', fit: BoxFit.cover),
),
              SizedBox(height: 25),
              TextFormField(
                controller: _accountController,
                decoration: InputDecoration(
                  labelText: "Account",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: pickImage,
                    icon: Icon(Icons.image),
                    label: Text('Pick Image'),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    editProfile(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(25),
                  ),
                  child: const Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
