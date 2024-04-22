import 'package:flutter/material.dart';
import 'dart:convert';
import './user_model.dart';
import 'package:provider/provider.dart';

Future<void> waterModeLogin(BuildContext context) async {
      Provider.of<UserModel>(context, listen: false).setToken('jwttoken');
      Navigator.pushReplacementNamed(context, '/home');
}
