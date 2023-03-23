// ignore_for_file: unrelated_type_equality_checks

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:online_booking/utils/constants/color.dart';
import 'package:online_booking/utils/constants/constants-width.dart';
import 'package:online_booking/widgets/custom_button.dart';
import 'package:online_booking/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../model/car_model/add_car_model.dart';
import '../../utils/routes/routes.dart';
import '../../view_model/car_view_model/car_view_model.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

// creating two text controllers for color and registration number
final myControllerColor = TextEditingController();
final myControllerRegistration = TextEditingController();
// defining the car make and model options as arrays
String carMake = 'Nisan';
String carModel = '2015';
int _previousNumber = 0;
int _currentNumber = 0;
// defining a function to generate a new number to obtain id
void _generateNewNumber() {
  final random = Random();
  do {
    _previousNumber = _currentNumber;
    _currentNumber = random.nextInt(2000);
  } while (_previousNumber == _currentNumber);
  print('New number: $_currentNumber');
}

// defining the car make and car model options as arrays
var items = [
  'Nisan',
  'Honda',
  'Mercedies',
  'Audi',
  'BMW',
];

var model = [
  '2015',
  '2016',
  '2017',
  '2018',
  '2019',
  '2020',
  '2021',
  '2022',
  '2023',
];

// defining a State class _AddCarScreenState to manage the state of the AddCarScreen widget
class _AddCarScreenState extends State<AddCarScreen> {
  @override
  void initState() {
    super.initState();
  }

  void clear() {
    myControllerColor.clear();
    myControllerRegistration.clear();
    carMake=="";
    carModel=="";
  }

  bool validData() {
    if (myControllerColor.text.isEmpty) {
      // show snackbar if color is not entered
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Enter Color"),
        duration: Duration(milliseconds: 500),
      ));

      return false;
    }
    if (myControllerRegistration.text.isEmpty) {
      // show snackbar if registration number is not entered
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Enter Registration Number"),
        duration: Duration(milliseconds: 1000),
      ));
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    // build the UI of the widget using the Scaffold widget
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0.6),
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(120), // Set this height
                child: SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColor.buttonColor,
                          size: 35,
                        ),
                      ),
                      text(
                          text: 'Add Car',
                          fontsize: 19.0,
                          color: AppColor.white,
                          fontweight: FontWeight.bold),
                      const SizedBox(
                        height: 20,
                        width: 40,
                      )
                    ],
                  ),
                )),
            body: Padding(
              padding: MediaQuery.of(context).viewInsets.bottom > 0
                  ? const EdgeInsets.only(top: 0)
                  : const EdgeInsets.only(top: 0),
              child: SizedBox(
                height: Constants.getHeight(context) * 0.6,
                width: Constants.getWidth(context) * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //text Field Car Color
                    component(
                      hintText: 'Enter Car Color',
                      textediting: myControllerColor,
                    ),
                    //text Field Registration Number
                    component(
                      hintText: 'Enter Registration Number',
                      textediting: myControllerRegistration,
                    ),
                    //drop down Car Make Companies
                    Container(
                      height: Constants.getHeight(context) * 0.06,
                      width: Constants.getWidth(context) * 0.8,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13)),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        ),
                        color: AppColor.white,
                      ),
                      child: DropdownButton(
                        menuMaxHeight: 140,
                        isExpanded: true,
                        // Initial Value
                        value: carMake,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: text(
                                    text: items,
                                    color:
                                        AppColor.blackColor.withOpacity(0.5)),
                              ));
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            carMake = newValue!;
                          });
                        },
                      ),
                    ),
                    //Drop Down for select car models
                    Container(
                      height: Constants.getHeight(context) * 0.06,
                      width: Constants.getWidth(context) * 0.8,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13)),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        ),
                        color: AppColor.white,
                      ),
                      child: DropdownButton(
                        menuMaxHeight: 140,
                        isExpanded: true,
                        // Initial Value
                        value: carModel,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: model.map((String model) {
                          return DropdownMenuItem(
                              value: model,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: text(
                                    text: model,
                                    color:
                                        AppColor.blackColor.withOpacity(0.5)),
                              ));
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            carModel = newValue!;
                          });
                        },
                      ),
                    ),
                    //Adding car data into provider state
                    SizedBox(
                        width: Constants.getWidth(context) * 0.8,
                        child: InkWell(
                            onTap: () {
                              _generateNewNumber();
                              if (validData()) {
                                final car = CarModel(
                                  id: _currentNumber,
                                  carModel: carModel,
                                  color: myControllerColor.text,
                                  make: carMake,
                                  registrationNo: myControllerRegistration.text,
                                );
                                Provider.of<CarViewModel>(context,
                                        listen: false)
                                    .addCar(
                                  car,
                                );
                                clear();
                                Navigator.pushNamed(
                                  context,
                                  ScreenRoutes.viewCar,
                                );
                              }
                            },
                            child: customButton(
                                context: context, title: 'Add Car '))),
                    //button to view all added card
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ScreenRoutes.viewCar,
                        );
                      },
                      child: SizedBox(
                          width: Constants.getWidth(context) * 0.8,
                          child: customButton(
                              context: context, title: 'View Car')),
                    )
                  ],
                ),
              ),
            )));
  }

//this component is custom text field
  Widget component({icon, hintText, textediting}) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Constants.getHeight(context) * 0.06,
        width: Constants.getWidth(context) * 0.8,
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
          color: AppColor.white,
        ),
        child: TextField(
          controller: textediting,
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintMaxLines: 1,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }
}
