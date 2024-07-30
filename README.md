## Dev Guideline

### Todo
**Author**: Jaydip Jadav  
**Date**: July 30, 2024
---

### Introduction
This is Documentation is Dev Guideline. With the help of document to developers can easily read and think.All information related to flutter development face has been improved in this document.

---

###  ****[UI](https://docs.flutter.dev/ui)****
Any design has to be made complex.  So any client should have an interactive design.
Any design should be good in appearance and also in color which will please the client.  
 
#### If you want to change the Flutter design, you have to manage the state.

State manage flutter can be done in <b> <i>2 ways</i></b>.
* state less widgets.
* state full widgets.

  
****[1) state less widgets](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html)****

The widgets whose state can not be altered once they are built are called stateless widgets. These widgets are immutable once they are built i.e. any amount of change in the variables, icons, buttons, or retrieving data can not change the state of the app.

****[2) state full widgets](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)****

The widgets whose state can be altered once they are built are called statefull Widgets. These states are mutable and can be changed multiple times in their lifetime. Classes that inherit “Stateful Widget” are immutable.

---

###  ****[Handling errors](https://docs.flutter.dev/testing/errors)****

* **Compile-time errors:**
These errors occur during the compilation of your Flutter code and typically involve syntax or typing mistakes.

* **Runtime errors:**
Runtime errors occur while the application runs and can arise from various sources, such as null references, invalid data, or unexpected behavior.

Flutter makes use of exceptions to handle runtime errors. You can use try-catch blocks to catch exceptions and perform specific actions based on the type of error encountered.

```
try {
Some code....
} catch(e) {
print(e); // error occurd this statement print.
```
---

****[Validating TextField](https://docs.flutter.dev/cookbook/forms/validation)****

you need to validate the Text field. otherwise, it can be null or empty. This will cause save the null values into the database.

```
final _text = TextEditingController();
bool _validate = false;

TextField(
    controller: _text,
    decoration: InputDecoration(
      labelText: 'Enter the Value',
      errorText: _validate ? 'Value not Empty' : null,
  ),
),

 ElevatedButton(
  onPressed: () {
    setState(() {
      _text.text.isEmpty ? _validate = true : _validate = false;
    });
  },
  child: Text(' Submit'),
)  
```
---


****[Verification](https://pub.dev/packages/flutter_verification_code)****

**Email Verification:** Sending a verification email to confirm the user's email address.<br>
**Phone Number Verification:** Sending an SMS with a verification code to confirm the user's phone number.<br>
**Third-Party Authentication:** Using services like Firebase Authentication, OAuth, and others to verify users through third-party providers (Google, Facebook, etc...).

***Run this command:
With Flutter:***

```
flutter pub add flutter_verification_code
```
***add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):***
```
dependencies:
  flutter_verification_code: ^1.1.7
```

**Email Verification:**
```
import 'package:firebase_auth/firebase_auth.dart';

void sendVerificationEmail() async {
  User user = FirebaseAuth.instance.currentUser;

  if (!user.emailVerified) {
    await user.sendEmailVerification();
    print('Verification email has been sent.');
  }
}
```
**Phone Number Verification:**
```
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
await auth.verifyPhoneNumber(
  phoneNumber: '+44 7123 123 456',
  verificationCompleted: (PhoneAuthCredential credential) async {
    // ANDROID ONLY!

    // Sign the user in (or link) with the auto-generated credential
 
```
---

*****Testing*******

Testing is one of the most important concept. App testing to check bugs and error in this app.
1) Unit Testing
=> it is the easiest method for testing an application or software.
=>it tests a single function, method, or class.
=>Execution Speed Fast.

2)Widget Testing
=> it widget testing to tests  a single widget.
=>Execution Speed Fast.

3)Integration Testing
=> In this testing involved both above testing method.
=>Execution Speed Slow. 

---

***App Size****

App size is important concept in Application.
1) Consider using SVG files instead of PNGs or JPEGs.
2) DevTools : It can be used to see a visual representation of app performance, network, memory, CPU and much more.
