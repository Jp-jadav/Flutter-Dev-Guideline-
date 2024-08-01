import 'package:flutter/material.dart';
import 'package:zodiac/DBHelper/db_handler.dart';
import 'package:zodiac/Models/registration.dart';

class UsersByZodiacScreen extends StatefulWidget {
  final String zodiacSign;

  const UsersByZodiacScreen({required this.zodiacSign, super.key});

  @override
  State<UsersByZodiacScreen> createState() => _UsersByZodiacScreenState();
}

class _UsersByZodiacScreenState extends State<UsersByZodiacScreen> {
  DatabaseHelper? dbHelper;
  late Future<List<Registration>> usersByZodiac;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    loadUsers();
  }

  loadUsers() async {
    setState(() {
      usersByZodiac = dbHelper!.getUsersByZodiacSign(widget.zodiacSign);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.zodiacSign} Users'),
      ),
      body: FutureBuilder<List<Registration>>(
        future: usersByZodiac,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No users found for this zodiac sign.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(user.zodiacSignImage),
                ),
                title: Text(user.name),
                subtitle: Text('DOB: ${user.dateOfBirth}'
                    '\nMobile: ${user.mobileNumber}'
                    '\nZodiac: ${user.zodiacSign}'
                    '\nGender: ${user.gender}'),
              );
            },
          );
        },
      ),
    );
  }
}
