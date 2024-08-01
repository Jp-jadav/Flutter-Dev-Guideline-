import 'package:zodiac/Models/registration.dart';

class Registration {
  int? id;
  final String name;
  final String dateOfBirth;
  final String mobileNumber;
  final String gender;
  final String zodiacSign;
  final String zodiacSignImage;

  Registration({
    this.id,
    required this.name,
    required this.dateOfBirth,
    required this.mobileNumber,
    required this.gender,
    required this.zodiacSign,
    required this.zodiacSignImage,
  });

  Registration.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        dateOfBirth = res['date_of_birth'],
        mobileNumber = res['mobile_number'],
        gender = res['gender'],
        zodiacSign = res['zodiac_sign'],
        zodiacSignImage = res['zodiac_sign_image'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'date_of_birth': dateOfBirth,
      'mobile_number': mobileNumber,
      'gender': gender,
      'zodiac_sign': zodiacSign,
      'zodiac_sign_image': zodiacSignImage,
    };
  }
}
