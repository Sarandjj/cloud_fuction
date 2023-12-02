import 'package:auth_fuction/modules/user_module.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/firebase_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllUsers();
  }

  List<dynamic> userList = [].obs;
  // UserListData? userListData;
  //User? user;
  // List userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.info))],
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            final user = userList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Card(
                  elevation: 18,
                  child: Container(
                    height: 120,
                    color: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Name :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    user['displayName'] ?? '11',
                                    //user?.name ?? 'ww',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Phone Number :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    user['phoneNumber'] ?? 'd',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Email Id :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    user['email'] ?? '11',
                                    //users['email'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                              highlightColor: Colors.red,
                              onPressed: () {
                                // print(users['uid']);

                                setState(() {
                                  firebaseService.deleteuser(user['uid']);
                                  getAllUsers();
                                });
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                size: 40,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ))
      ]),
    );
  }

  Future getAllUsers() async {
    try {
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'getAllUsers',
      );
      final HttpsCallableResult result = await callable.call();
      print(result.data['users']);

      setState(() {
        userList = result.data['users'];
      });
    } catch (e) {
      print('Error getting all users: $e');
    }
  }
}
