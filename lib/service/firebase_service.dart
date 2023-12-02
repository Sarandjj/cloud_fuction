import 'dart:convert';

import 'package:auth_fuction/modules/user_module.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  Userlistdata? userlistdata;
  List<dynamic> userList = [];
  List<User> user = [];
  HttpsCallable createUserCallable = FirebaseFunctions.instance.httpsCallable(
    'createUser',
  );
  HttpsCallable deleteCallable = FirebaseFunctions.instance.httpsCallable(
    'delete',
  );
  HttpsCallable getUserDataCallable = FirebaseFunctions.instance.httpsCallable(
    'getuser',
  );
  Future<void> createUser(String email, String password, String phoneNumber,
      String displayName) async {
    try {
      final result = await createUserCallable.call({
        'email': email,
        'password': password,
        'phoneNumber': '+91$phoneNumber',
        'displayName': displayName,
      });

      print(result.data['success']);

      if (result.data['uid'] != null && result.data['success'] == true) {
        await saveUserData(
          result.data['displayName'],
          result.data['phoneNumber'],
          result.data['email'],
          result.data['uid'],
        );
        print(
            'User created with UID: ${result.data['uid'] + result.data['displayName'] + result.data['phoneNumber'] + result.data['email']}');
      }
    } catch (e) {
      print('Error calling createUser Cloud Function: $e');
      throw Exception('Error calling createUser Cloud Function: ');
    }
  }

  Future<void> deleteuser(
    String uid,
  ) async {
    try {
      await deleteCallable.call({'uid': uid});
      //    print(a);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getuser(
    String uid,
  ) async {
    try {
      final user = await getUserDataCallable.call({'uid': uid});

      print(user.data['email']);
    } catch (e) {}
  }

  Future<void> saveUserData(
      String name, String phoneNumber, String email, String uid) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('name', name);
    prefs.setString('phoneNumber', phoneNumber);
    prefs.setString('email', email);
    prefs.setString('udi', uid);
  }

  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString('name') ?? '';
    final phoneNumber = prefs.getString('phoneNumber') ?? '';
    final email = prefs.getString('email') ?? '';
    final uid = prefs.getString('uid') ?? '';

    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'uid': uid
    };
  }
}
