import 'package:auth_fuction/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController usernameController = TextEditingController();
  FirebaseService firebaseService = FirebaseService();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController uidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Id',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  )),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),

              ElevatedButton(
                onPressed: () async {
                  try {
                    print(usernameController.text);
                    await firebaseService.createUser(
                        emailController.text,
                        passwordController.text,
                        phoneNumberController.text,
                        usernameController.text);

                    //await test();
                  } catch (e) {
                    print('Error creating user: $e');
                  }
                },
                child: const Text('Create User'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: uidController,
                decoration: const InputDecoration(
                  labelText: 'uid',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  await firebaseService.deleteuser(uidController.text);
                  //await test();
                  //await signIn();
                },
                child: const Text('Create Product'),
              ),
              // Display your products here using the 'products' list
            ],
          ),
        ),
      ),
    );
  }

  Future<void> test() async {
    print('object');
    await FirebaseFirestore.instance
        .collection("collectionPath")
        .doc()
        .set({'data': 'ssss'});
    print("object");
  }

  Future<bool> signIn() async {
    final creds = await FirebaseAuth.instance.signInAnonymously();
    debugPrint(creds.user?.uid);
    if (creds.user != null) {
      return true;
    }
    return false;
  }
}
