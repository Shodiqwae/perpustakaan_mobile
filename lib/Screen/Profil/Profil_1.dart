import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perpustakaan_mobile/Screen/Login/Login.dart';
import 'package:perpustakaan_mobile/Screen/Profil/Profil_2.dart';
import 'package:perpustakaan_mobile/service/modeluser.dart';

class Profile extends StatefulWidget {
  final int userId;

  Profile({required this.userId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserModel> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = getUserProfile(widget.userId);
  }

  Future<UserModel> getUserProfile(int userId) async {
    final String apiUrl = 'http://10.0.2.2:8000/api/getUserProfile/$userId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Height of AppBar
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold, // Mengatur tebal teks menjadi tebal
            ),
          ),
          centerTitle: true, // Untuk membuat judul berada di tengah
          backgroundColor: Color.fromRGBO(93, 23, 235, 1),  // Change the background color of the AppBar here
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0), // Radius for bottom left corner
              bottomRight: Radius.circular(20.0), // Radius for bottom right corner
            ),
          ),
        ),
      ),
      body: FutureBuilder<UserModel>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 150,
                      backgroundImage: NetworkImage(user.gambar),
                    ),
                    const SizedBox(height: 25),
                    itemProfile('Account', CupertinoIcons.person, user.name),
                    const SizedBox(height: 25),
                    itemProfile(user.email, Icons.email),
                    const SizedBox(height: 25),
                    ElevatedButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));  
                    },child: Text("Logout")),
                    const SizedBox(height: 25),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          final updatedUser = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Profile2(user: user),
                            ),
                          );

                          if (updatedUser != null) {
                            setState(() {
                              userFuture = Future.value(updatedUser);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(25),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget itemProfile(String title, IconData iconData, [String subtitle = '']) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.black.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
