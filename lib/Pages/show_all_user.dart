import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zodiac/DBHelper/db_handler.dart';
import 'package:zodiac/Models/registration.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper? dbHelper;
  late Future<List<Registration>> registrationList;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    loadData();
  }

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
        title: Text("widget.title"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: registrationList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
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
                                  backgroundImage: AssetImage(
                                      snapshot.data![index].zodiacSignImage),
                                ),
                              ),
                              Container(
                                // snapshot.data![index].zodiacSignImage,
                                margin: const EdgeInsets.only(left: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name :${snapshot.data![index].name}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Mobile :${snapshot.data![index].mobileNumber}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Gender :${snapshot.data![index].gender}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Zodiac : ${snapshot.data![index].zodiacSign}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "DOB : ${snapshot.data![index].dateOfBirth}",
                                      style: const TextStyle(fontSize: 20),
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
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ))
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
