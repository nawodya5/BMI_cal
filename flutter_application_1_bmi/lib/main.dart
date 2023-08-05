// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:form_field_validator/form_field_validator.dart';
import 'package:regexed_validator/regexed_validator.dart';
//import 'package:flutter/src/services/asset_manifest.dart';
//import 'package:google_fonts/src/asset_manifest.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue, // Change the primary color
        fontFamily: 'Roboto', // Change the default font family
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        backgroundColor: Colors.blue,
        duration: 500,
        splash: Text(
          'BMI Calculator',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        nextScreen: UserInfoScreen(),
      ),
      //UserInfoScreen(),
    );
  }
}

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double _value = 100;
  //TextEditingController heightController = TextEditingController();

  String gender = 'Male';
  DateTime selectedDate = DateTime.now();

  int age = 0;
  double bmi = 0.0;
  String bmiComment = '';
  int genderVal = 0;
  void refreshForm() {
    setState(() {
      // Clear the form fields and reset variables
      nameController.clear();
      addressController.clear();
      weightController.clear();
      _value = 100;
      //heightController.clear();
      gender = 'Male';
      selectedDate = DateTime.now();
      age = 0;
      bmi = 0.0;
      bmiComment = '';
    });
  }

  void calculateAge() {
    final currentDate = DateTime.now();
    age = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month &&
            currentDate.day < selectedDate.day)) {
      age--;
    }
  }

  void calculateBMI() {
    double height = (_value);
    double weight = double.tryParse(weightController.text) ?? 0.0;

    if (weight != null && height != null && height > 0) {
      bmi = weight / ((height / 100) * (height / 100));
      if (bmi < 18.5) {
        bmiComment = 'You are Underweight';
      } else if (bmi < 25) {
        bmiComment = 'You are Normal weight';
      } else if (bmi < 30) {
        bmiComment = 'You are Overweight';
      } else {
        bmiComment = 'You are Obese';
      }
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      double height = _value;
      double weight = double.tryParse(weightController.text) ?? 0.0;

      if (weight > 200 || height > 250) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Measurements'),
              content: Text('Please enter valid weight and height.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      calculateAge();
      calculateBMI();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            title: Center(
                child: Text(
              'BMI INFORMATION',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    width: double.maxFinite,
                    height: containerHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Color.fromARGB(255, 91, 133, 224),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(' Name', style: bmiText)),
                        Expanded(
                          flex: 2,
                          child: Text(': ' + nameController.text),
                        )
                      ],
                    )),
                Container(
                    width: double.maxFinite,
                    height: containerHeight,
                    color: Color.fromARGB(255, 92, 139, 240),
                    child: Row(
                      children: [
                        Expanded(child: Text(' Address', style: bmiText)),
                        Expanded(
                          flex: 2,
                          child: Text(': ' + addressController.text),
                        )
                      ],
                    )),
                Container(
                    width: double.maxFinite,
                    height: containerHeight,
                    color: Color.fromARGB(255, 13, 69, 190),
                    child: Row(
                      children: [
                        Expanded(child: Text(' Gender', style: bmiText)),
                        Expanded(
                          flex: 2,
                          child: Text(': ' + gender),
                        )
                      ],
                    )),
                Container(
                    width: double.maxFinite,
                    height: 50,
                    color: Color.fromARGB(255, 13, 69, 190),
                    child: Row(
                      children: [
                        Expanded(child: Text(' Birth Date', style: bmiText)),
                        Expanded(
                          flex: 2,
                          child: Text(': ' +
                              DateFormat('dd/MM/yyyy').format(selectedDate)),
                        )
                      ],
                    )),
                Container(
                    width: double.maxFinite,
                    height: containerHeight,
                    color: Color.fromARGB(255, 13, 69, 190),
                    child: Row(
                      children: [
                        Expanded(child: Text(' Age', style: bmiText)),
                        Expanded(
                          flex: 2,
                          child: Text(': ' + age.toString()),
                        )
                      ],
                    )),
                Container(
                    width: double.maxFinite,
                    height: containerHeight,
                    color: Color.fromARGB(255, 13, 69, 190),
                    child: Row(
                      children: [
                        Expanded(child: Text(' Weight', style: bmiText)),
                        Expanded(
                          flex: 2,
                          child: Text(': ' + weightController.text + ' Kg'),
                        )
                      ],
                    )),
                Container(
                    width: double.maxFinite,
                    height: containerHeight,
                    color: Color.fromARGB(255, 13, 69, 190),
                    child: Row(
                      children: [
                        Expanded(child: Text(' Height', style: bmiText)),
                        Expanded(
                          flex: 2,
                          child: Text(': ' + _value.round().toString() + ' cm'),
                        )
                      ],
                    )),
                Container(
                    width: double.maxFinite,
                    height: containerHeight,
                    color: Color.fromARGB(255, 13, 69, 190),
                    child: Row(
                      children: [
                        Expanded(child: Text(' BMI', style: bmiText)),
                        Expanded(
                          flex: 2,
                          child: Text(': ' + bmi.toStringAsFixed(2)),
                        )
                      ],
                    )),
                Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    height: containerHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color.fromARGB(255, 13, 69, 190),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(' Comment', style: bmiText)),
                        Expanded(
                          flex: 2,
                          child: Text(': ' + bmiComment),
                        )
                      ],
                    )),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close', style: TextStyle(fontSize: 16)),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         opacity: 0.4,
            //         image: AssetImage("assets/images/back1.jpeg"),
            //         fit: BoxFit.cover)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 100.0,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: const [
                        Color.fromARGB(255, 13, 69, 190),
                        Color.fromARGB(255, 13, 69, 190),
                        Color.fromARGB(255, 13, 69, 190),
                      ],
                    ),
                    boxShadow: const [
                      BoxShadow(blurRadius: 40.0),
                    ],
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0)),
                  ),
                  child: Text(
                    'BMI  CALCULATOR',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 59,
                                decoration: BoxDecoration(
                                    // color: Colors.green,

                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  //labelText: 'User Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor:
                                      Color.fromARGB(255, 176, 201, 254)),
                              validator: (value) {
                                if (value == null || validator.name(value)) {
                                  return 'Please enter a valid name';
                                } else if (!(value
                                    .isAlphabetOnly(value.toString()))) {
                                  return 'Please enter only letters';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Address',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(children: [
                          customElevation(),
                          TextFormField(
                            controller: addressController,
                            decoration: InputDecoration(
                                //labelText: 'Address',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 176, 201, 254)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                        ]),
                        SizedBox(height: 20),
                        Text('Gender',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => setState(() {
                                genderVal = 0;
                                gender = 'Male';
                              }),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.5),
                                  borderRadius: BorderRadius.circular(20),
                                  color: genderVal == 0
                                      ? Color.fromARGB(255, 176, 201, 254)
                                      : Colors.transparent,
                                ),
                                height: 70,
                                width: 190,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Icon(FontAwesomeIcons.person),
                                    Text('Male', style: TextStyle(fontSize: 15))
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () => setState(() {
                                genderVal = 1;
                                gender = 'Female';
                              }),
                              child: Container(
                                decoration: BoxDecoration(
                                  //boxShadow: ,
                                  border: Border.all(width: 1.5),
                                  borderRadius: BorderRadius.circular(20),
                                  color: genderVal == 1
                                      ? Color.fromARGB(255, 176, 201, 254)
                                      : Colors.transparent,
                                ),
                                height: 70,
                                width: 190,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.personDress,
                                      //color: Colors.pinkAccent,
                                    ),
                                    Text(
                                      'Female',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Date of Birth',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  selectedDate = value;
                                });
                              }
                            });
                          },
                          child: Stack(children: [
                            customElevation(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 59,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 176, 201, 254),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today_outlined),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(selectedDate),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Weight',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(children: [
                          customElevation(),
                          TextFormField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Weight',
                                hintText: 'Weight (KG)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 176, 201, 254)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your weight';
                              } else if (value
                                  .isAlphabetOnly(value.toString())) {
                                return 'Please enter valid value';
                              }
                              return null;
                            },
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Height',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding:
                                EdgeInsets.only(top: 10, right: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 176, 201, 254),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Slider(
                                      divisions: 300,
                                      min: 0.0,
                                      max: 300.0,
                                      value: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                          _value.round().toString() + ' cm'))
                                ],
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: submitForm,
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 40),
                              elevation: 10,
                              shadowColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('Calculate',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: refreshForm,
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 40),
                              elevation: 10,
                              shadowColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child:
                                Text('Reset', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class customElevation extends StatelessWidget {
  const customElevation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 59,
        decoration: BoxDecoration(
            // color: Colors.green,

            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

TextStyle bmiText =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
double containerHeight = 30;
