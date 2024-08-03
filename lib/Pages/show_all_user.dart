import 'package:flutter/material.dart';
import 'package:zodiac/DBHelper/db_handler.dart';
import 'package:zodiac/Models/registration.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  DatabaseHelper? dbHelper;
  late Future<List<Registration>> registrationList;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    loadData();
  }

  // get all users in to database
  loadData() async {
    setState(() {
      registrationList = dbHelper!.getRegistrationList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("All Users"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: registrationList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No zodiac user found.'));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 30, // Adjust the radius as needed
                                backgroundImage:
                                    AssetImage(data.zodiacSignImage),
                              ),
                            ),
                            Container(
                              // snapshot.data![index].zodiacSignImage,
                              margin: const EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name :${data.name}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "Mobile :${data.mobileNumber}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "Gender :${data.gender}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "Zodiac : ${data.zodiacSign}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "DOB : ${data.dateOfBirth}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
