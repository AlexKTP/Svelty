import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class WeightPicker extends StatefulWidget {

  WeightPicker({super.key});

  late WeightPickerState weightPickerState;

  //TODO Avoid logic. See Provider?

  @override
  WeightPickerState createState(){
    weightPickerState = WeightPickerState();
    return weightPickerState;
  }

  double getWeight(){
    return weightPickerState.currentDoubleValue;
  }
}

class WeightPickerState extends State<WeightPicker> {
  double currentDoubleValue = 60;

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DecimalNumberPicker(
                value: currentDoubleValue,
                minValue: 30,
                maxValue: 90,
                decimalPlaces: 1,
                onChanged: (value) =>
                    setState(() =>currentDoubleValue = value),
              )
            ],
          ));
  }

  double getWeight(){
    return currentDoubleValue;
  }

}
