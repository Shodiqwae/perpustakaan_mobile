import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perpustakaan_mobile/Screen/Register/Register.dart';
import 'package:perpustakaan_mobile/page/home_page.dart';
import 'package:perpustakaan_mobile/service/modeluser.dart';
import 'dart:convert';


class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context, String email, String password) async {
    final String apiUrl = 'http://10.0.2.2:8000/api/login';
    
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final user = UserModel.fromJson(responseData['user']); // Parsing user data
      final token = responseData['token'];
      print('Login successful: $token');

      // Navigasi ke HomePage dengan mengirimkan user
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePP(user: user)),
      );
    } else {
      print('Failed to login: ${response.statusCode}');
      // Tampilkan pesan error jika login gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed, please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/buku.png",
                        height: 140,
                        width: 336,
                      ),
                      SizedBox(height: 70),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(height: 90),
                      ElevatedButton(
                        onPressed: () {
                          login(context, emailController.text, passwordController.text);
                        },
                        child: Text("Login"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        ),
                      ),
                      SizedBox(height: 30), // Added space between buttons
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text("Register"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        ),
                      ),
                    ],
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
