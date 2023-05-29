import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  String id;
  String name;

  User({required this.id, required this.name});

  factory User.createUser(Map<String, dynamic> object) {
    return User(id: object['id'], name: object['first_name']);
  }

  static Future<User> connectToAPI(String id) async {
    String apiURL = "https://reqres.in/api/users/$id";

    var apiResult = await http.get(apiURL as Uri);
    var jsonObject = jsonDecode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)['data'];

    return User.createUser(userData);
  }
}
