import 'package:flutter/material.dart';
import 'package:online_booking/model/car_model/add_car_model.dart';
import 'package:online_booking/utils/constants/utils_message.dart';

class CarViewModel extends ChangeNotifier {
  final List<CarModel> _cars = [];

  List<CarModel> get cars => _cars;

  void addCar(CarModel car) {
    _cars.add(car);
    Utils.toastMessage(message: "Added Successfully");
    notifyListeners();
  }

  void updateCar(CarModel car) {
    int index = _cars.indexWhere((element) => element.id == car.id);
    _cars[index] = car;
    Utils.toastMessage(message: "Updated Successfully");
    notifyListeners();
  }

  void deleteCar(int id) {
    _cars.removeWhere((element) => element.id == id);
    Utils.toastMessage(message: "Deleted Successfully");
    notifyListeners();
  }
}
