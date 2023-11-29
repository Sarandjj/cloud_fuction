import 'package:cloud_functions/cloud_functions.dart';
//import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  HttpsCallable createUserCallable = FirebaseFunctions.instance.httpsCallable(
    'createUser',
  );
  HttpsCallable delete = FirebaseFunctions.instance.httpsCallable(
    'delete',
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
      //    print(a);
      if (result.data != null &&
          result.data['success'] != null &&
          result.data['success']) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        print('User created with UID: ${result.data['uid']}');
      } else {
        //final errorMessage = result.data['error'] ?? 'Unknown error';
        print('Error creating user: ');
        throw Exception('Error creating user: ');
      }
    } catch (e) {
      print('Error calling createUser Cloud Function: ');
      throw Exception('Error calling createUser Cloud Function: ');
    }
  }

  Future<void> deleteuser(
    String uid,
  ) async {
    try {
      await delete.call({'uid': uid});
      //    print(a);
    } catch (e) {}
  }
}
