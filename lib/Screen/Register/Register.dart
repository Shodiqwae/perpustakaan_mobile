import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perpustakaan_mobile/Screen/Login/Login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      Dio dio = Dio();
      dio.options.validateStatus = (status) {
        return status! < 500; // Allow all status codes less than 500
      };

      try {
        final response = await dio.post(
          'http://10.0.2.2:8000/api/register', // URL ini harus sesuai dengan rute di api.php
          data: {
            'name': _username,
            'email': _email,
            'password': _password,
            'password_confirmation': _confirmPassword,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json', // Pastikan header sesuai
            },
          ),
        );

        print('Response status: ${response.statusCode}');
        print('Response data: ${response.data}');
        print('Response headers: ${response.headers}');

        if (response.statusCode == 201 || response.statusCode == 200) {
          Fluttertoast.showToast(msg: 'Registration successful');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          Fluttertoast.showToast(msg: 'Registration failed: ${response.data['message']}');
        }
      } catch (e) {
        print('Error occurred: $e'); // Print error detail
        Fluttertoast.showToast(msg: 'An error occurred: $e');
      }
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
                  key: _formKey,
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
                        decoration: InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        onSaved: (value) {
                          _username = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        onSaved: (value) {
                          _email = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _confirmPassword = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: _register,
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
