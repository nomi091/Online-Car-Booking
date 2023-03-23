import 'package:flutter/material.dart';
import 'package:online_booking/utils/constants/color.dart';
import 'package:online_booking/view/home_view/update_car_view.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/constants-width.dart';
import '../../utils/routes/routes.dart';
import '../../view_model/car_view_model/car_view_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_widget.dart';

class ViewCarScreen extends StatefulWidget {
  const ViewCarScreen({Key? key}) : super(key: key);

  @override
  State<ViewCarScreen> createState() => _ViewCarScreenState();
}

class _ViewCarScreenState extends State<ViewCarScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<CarViewModel>(builder: (context, value, child) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120), // Set this height
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColor.buttonColor,
                      size: 35,
                    ),
                  ),
                  text(
                      text: 'View All Car',
                      fontsize: 19.0,
                      color: AppColor.blackColor,
                      fontweight: FontWeight.bold),
                  const SizedBox(
                    height: 20,
                    width: 40,
                  )
                ],
              ),
            )),
        body: value.cars.isEmpty
            //if cars data is empty then this screen will display
            ? SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    // color: Colors.amber,
                    height: Constants.getHeight(context) * 0.8,
                    width: Constants.getWidth(context) * 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset(AppImages.emptyCart),
                        const SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                          height: Constants.getHeight(context) * 0.4,
                          child: text(
                              text: 'No Car Available',
                              fontsize: 18.0,
                              fontweight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ScreenRoutes.addCar,
                            );
                          },
                          child: customButton(
                              context: context, title: 'Start Adding'),
                        ),
                      ],
                    ),
                  )
                ]),
              )
          //if cars model contains data then this code will display
            : Center(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: Constants.getHeight(context) * 0.85,
                    width: Constants.getWidth(context) * 0.9,
                    child: Column(
                      children: [
                        text(
                            text:
                                'Total Number Of Cars Added: ${value.cars.length}',
                            fontsize: 15.0,
                            fontweight: FontWeight.bold),
                        const SizedBox(
                          height: 10,
                        ),
                        //display all the cars data
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: value.cars.length,
                              //   itemExtent: 100,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      color:
                                          AppColor.cardColor.withOpacity(0.10),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            child: FadeInImage(
                                              height: 80,
                                              width: 130,
                                              placeholder: const AssetImage(
                                                  'assets/place_holder.webp'),
                                              image: const NetworkImage(
                                                  'https://www.indiacarnews.com/wp-content/uploads/2022/04/Kia-EV6-India.jpg'),
                                              fit: BoxFit.cover,
                                              imageErrorBuilder:
                                                  (context, object, trace) {
                                                return Image.asset(
                                                  width: 100,
                                                  height: 100,
                                                  'assets/place_holder.webp',
                                                  fit: BoxFit.fitWidth,
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            width: Constants.getWidth(context) *
                                                0.3,
                                            height:
                                                Constants.getHeight(context) *
                                                    0.12,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    text(
                                                        text: 'Color: ',
                                                        fontweight:
                                                            FontWeight.bold),
                                                    text(
                                                        text: value
                                                            .cars[index].color
                                                            .toString()),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    text(
                                                        text: 'Model: ',
                                                        fontweight:
                                                            FontWeight.bold),
                                                    text(
                                                        text: value.cars[index]
                                                            .carModel),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    text(
                                                        text: 'Make: ',
                                                        fontweight:
                                                            FontWeight.bold),
                                                    text(
                                                        text: value
                                                            .cars[index].make),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    text(
                                                        text: 'RegNo: ',
                                                        fontweight:
                                                            FontWeight.bold),
                                                    Flexible(
                                                        child: Text(
                                                            value.cars[index]
                                                                .registrationNo,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            )))

                                                    //    text(
                                                    //       text: value
                                                    //           .cars[index]
                                                    //           .registrationNo),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Provider.of<CarViewModel>(
                                                          context,
                                                          listen: false)
                                                      .deleteCar(
                                                    value.cars[index].id,
                                                  );
                                                },
                                                child: const Icon(Icons.delete),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UpdateCarView(
                                                              index: value
                                                                  .cars[index],
                                                            )),
                                                  );
                                                },
                                                child: const Icon(Icons.edit),
                                              )
                                            ],
                                          ),
                                        ]),
                                  ),
                                );
                              }),
                        ),
                        //button is used to add new car data
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ScreenRoutes.addCar,
                              );
                            },
                            child: customButton(
                                context: context, title: 'Add More'))
                      ],
                    ),
                  ),
                ),
              ),
      );
    }));
  }
}
