import 'package:flutter/material.dart';
import 'package:zodiac/DBHelper/db_handler.dart';
import 'package:zodiac/Pages/registration_screen.dart';
import 'package:zodiac/Pages/show_all_user.dart';
import 'package:zodiac/Pages/users_by_zodiac_screen.dart'; // Import the new page

class ZodiacGroupScreen extends StatefulWidget {
  const ZodiacGroupScreen({super.key});

  @override
  State<ZodiacGroupScreen> createState() => _ZodiacGroupScreenState();
}

class _ZodiacGroupScreenState extends State<ZodiacGroupScreen> {
  DatabaseHelper? dbHelper;
  late Future<List<String>> zodiacSigns;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    loadZodiacSigns();
  }

  // get zodiac sign
  loadZodiacSigns() async {
    setState(() {
      zodiacSigns = dbHelper!.getDistinctZodiacSigns();
    });
  }

  // Data Refresh
  void refreshData() {
    loadZodiacSigns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zodiac Signs'),
      ),
      body: FutureBuilder<List<String>>(
        future: zodiacSigns,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No zodiac signs found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final zodiacSign = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 20,
                  color: Colors.white70,
                  child: ListTile(
                    title: Text(zodiacSign),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UsersByZodiacScreen(zodiacSign: zodiacSign),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 30),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllUsersScreen(),
                      ));
                },
                child: const Text("Show All Users")),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RegistrationScreen(onSave: refreshData),
                  ));
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
