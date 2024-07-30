## Dev Guideline

# Introduction
Any design has to be made complex.  So any client should have an interactive design.

Any design should be good in appearance and also in color which will please the client.  

If you want to change the Flutter design, you have to manage the state.

State manage flutter can be done in 2 ways.
* state less widgets.
* state full widgets.

>>state less widget.

=>The widgets whose state can not be altered once they are built are called stateless widgets.
=>These widgets are immutable once they are built i.e. any amount of change in the variables, icons, buttons, or retrieving data can not change the state of the app.

>>state full widgets.

=>The widgets whose state can be altered once they are built are called statefull Widgets.
=>These states are mutable and can be changed multiple times in their lifetime.
=>Classes that inherit “Stateful Widget” are immutable.

******Handling Error*********
1> Compile-time errors
These errors occur during the compilation of your Flutter code and typically involve syntax or typing mistakes.

2>Runtime errors
Runtime errors occur while the application runs and can arise from various sources, such as null references, invalid data, or unexpected behavior.

Flutter makes use of exceptions to handle runtime errors. You can use try-catch blocks to catch exceptions and perform specific actions based on the type of error encountered.

```
try {
Some code....
} catch(e) {
print(e); // error occurd this statement print.
```

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

***App Size****

App size is important concept in Application.
1) Consider using SVG files instead of PNGs or JPEGs.
2) DevTools : It can be used to see a visual representation of app performance, network, memory, CPU and much more.
