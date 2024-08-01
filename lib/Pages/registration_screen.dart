import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zodiac/DBHelper/db_handler.dart';
import 'package:zodiac/Models/registration.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String? _gender;
  bool _tableExists = false;
  DatabaseHelper? dbHelper;
  late Future<List<Registration>> registrationsList;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    loadData();
    _checkTable();
  }

  loadData() async {
    registrationsList = dbHelper!.getRegistrationList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  String _calculateZodiac(DateTime date) {
    int day = date.day;
    int month = date.month;

    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      return "Aquarius";
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      return "Pisces";
    } else if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      return "Aries";
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      return "Taurus";
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      return "Gemini";
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      return "Cancer";
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      return "Leo";
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      return "Virgo";
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      return "Libra";
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      return "Scorpio";
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      return "Sagittarius";
    } else if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) {
      return "Capricorn";
    } else {
      return "Unknown";
    }
  }

  String _getZodiacImage(String zodiacSign) {
    switch (zodiacSign) {
      case "Aquarius":
        return "assets/zodiac/aquarius.png";
      case "Pisces":
        return "assets/zodiac/pisces.png";
      case "Aries":
        return "assets/zodiac/aries.png";
      case "Taurus":
        return "assets/zodiac/taurus.png";
      case "Gemini":
        return "assets/zodiac/gemini.png";
      case "Cancer":
        return "assets/zodiac/cancer.png";
      case "Leo":
        return "assets/zodiac/leo.png";
      case "Virgo":
        return "assets/zodiac/virgo.png";
      case "Libra":
        return "assets/zodiac/libra.png";
      case "Scorpio":
        return "assets/zodiac/scorpio.png";
      case "Sagittarius":
        return "assets/zodiac/sagittarius.png";
      case "Capricorn":
        return "assets/zodiac/capricorn.png";
      default:
        return "assets/zodiac/unknown.png";
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      DateTime dob = DateFormat('yyyy-MM-dd').parse(_dobController.text);
      String zodiacSign = _calculateZodiac(dob);
      String zodiacSignImage = _getZodiacImage(zodiacSign);

      Registration registration = Registration(
          name: _nameController.text,
          dateOfBirth: _dobController.text,
          mobileNumber: _mobileController.text,
          gender: _gender!,
          zodiacSign: zodiacSign,
          zodiacSignImage: zodiacSignImage);

      await dbHelper!.insert(registration).then(
        (value) {
          setState(() {
            registrationsList = dbHelper!.getRegistrationList();
          });

          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration saved!")),
          );
        },
      );

      print("Name: ${_nameController.text}");
      print("Date of Birth: ${_dobController.text}");
      print("Zodiac Sign: $zodiacSign");
      print("Mobile Number: ${_mobileController.text}");
      print("Gender: $_gender");

      // Clear the form
      _formKey.currentState!.reset();
      _nameController.clear();
      _dobController.clear();
      _mobileController.clear();
      setState(() {
        _gender = null;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTitle(),
                _buildNameField(),
                _buildDOBField(context),
                _buildMobileField(),
                _buildGenderField(),
                const SizedBox(height: 20),
                _buildSubmitButton(),
                _checkTableExistsOrNot(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: const Text(
        'Register',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildNameField() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _nameController,
        decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDOBField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _dobController,
        decoration: const InputDecoration(
          labelText: 'Date of Birth',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your date of birth';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildMobileField() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: _mobileController,
        decoration: const InputDecoration(
          labelText: 'Mobile Number',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.phone),
        ),
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your mobile number';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderField() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person_outline),
        ),
        value: _gender,
        onChanged: (String? newValue) {
          setState(() {
            _gender = newValue;
          });
        },
        items: <String>['Male', 'Female']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select your gender';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: const Text(
        'Submit',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _checkTableExistsOrNot() {
    return Center(
      child: _tableExists
          ? const Text("Registration table exists.")
          : const Text("Registration table does not exist."),
    );
  }

  Future<void> _checkTable() async {
    bool exists = await dbHelper!.checkTableExists('registration');
    setState(() {
      _tableExists = exists;
    });
  }
}
