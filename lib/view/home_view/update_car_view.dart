// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:online_booking/model/car_model/add_car_model.dart';
import 'package:online_booking/utils/constants/color.dart';
import 'package:online_booking/utils/constants/constants-width.dart';
import 'package:online_booking/widgets/custom_button.dart';
import 'package:online_booking/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/routes.dart';
import '../../view_model/car_view_model/car_view_model.dart';

class UpdateCarView extends StatefulWidget {
  final index;
  const UpdateCarView({Key? key, this.index}) : super(key: key);

  @override
  State<UpdateCarView> createState() => _UpdateCarViewState();
}

// Create TextEditingController objects for the color and registration number fields
final myControllerColor = TextEditingController();
final myControllerRegistration = TextEditingController();
// Initialize two arrays for the car make and car model fields respectively
String carMake = '';
String carModel = '';
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

class _UpdateCarViewState extends State<UpdateCarView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      // Display a back arrow icon
                      Icon(
                        Icons.arrow_back,
                        color: AppColor.buttonColor,
                        size: 35,
                      ),
                      text(
                          text: 'Update Car',
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
                    // Create a reusable component widget for the color and registration number fields

                    component(
                      hintText: widget.index.color,
                      textediting: myControllerColor,
                    ),
                    component(
                      hintText: widget.index.registrationNo,
                      textediting: myControllerRegistration,
                    ),
                    // Container for dropdown list of car makers

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
                        // Set the maximum height of dropdown menu

                        menuMaxHeight: 140,
                        isExpanded: true,
                        underline: const SizedBox(),
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: text(
                              text:
                                  carMake == "" ? widget.index.make : carMake),
                        ),
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
                    // Container for dropdown list of car models

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
                        // Set the maximum height of dropdown menu
                        menuMaxHeight: 140,
                        isExpanded: true,
                        underline: const SizedBox(),
                        // Placeholder text for dropdown button
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: text(
                              text: carModel == ""
                                  ? widget.index.carModel.toString()
                                  : carModel),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items for dropdown list
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
                    SizedBox(
                        width: Constants.getWidth(context) * 0.8,
                        child: InkWell(
                            onTap: () {
                              // Create a new CarModel object with updated values and update the car

                              final car = CarModel(
                                id: widget.index.id,
                                carModel: carModel == ""
                                    ? widget.index.carModel
                                    : carModel,
                                color: myControllerColor.text == ""
                                    ? widget.index.color
                                    : myControllerColor.text,
                                make:
                                    carMake == "" ? widget.index.make : carMake,
                                registrationNo:
                                    myControllerRegistration.text == ""
                                        ? widget.index.registrationNo
                                        : myControllerRegistration.text,
                              );
                              Provider.of<CarViewModel>(context, listen: false)
                                  .updateCar(
                                car,
                              );

                              Navigator.pushNamed(
                                context,
                                ScreenRoutes.viewCar,
                              );
                            },
                            child: customButton(
                                context: context, title: 'Update Car '))),
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
