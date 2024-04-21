import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './user_model.dart';
import 'package:provider/provider.dart';

Future<void> loginUser(BuildContext context, String username, String password) async {
  var url = Uri.parse('http://localhost:8500/api/login');
  try {
    var response = await http.post(
      url,
      body: json.encode({
        'username': username,
        'password': password
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("Login successful: ${data['jwttoken']}");
      // Token'ı global state'e kaydetme
      Provider.of<UserModel>(context, listen: false).setToken(data['jwttoken']);
      Navigator.pushReplacementNamed(context, '/home'); 
    } else {
      print("Failed to login: ${response.body}");
    }
  } catch (e) {
    print("Error occurred: $e");
  }
}
