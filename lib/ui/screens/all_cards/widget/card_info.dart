import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  static var numberValue = ValueNotifier(' ');
  static var dateValue = ValueNotifier(' ');
  static var nameValue = ValueNotifier(' ');
  static var ownerValue = ValueNotifier(' ');
  const CardInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
            valueListenable: nameValue,
            builder: (BuildContext context, String newValue, Widget? child) {
              return Text(
                newValue,
                style: const TextStyle(color: Colors.white),
              );
            }),
        const SizedBox(height: 5),
        ValueListenableBuilder(
            valueListenable: numberValue,
            builder: (BuildContext context, String newValue, Widget? child) {
              return Text(
                newValue,
                style: const TextStyle(fontSize: 22, color: Colors.white),
              );
            }),
        const SizedBox(height: 5),
        ValueListenableBuilder(
            valueListenable: dateValue,
            builder: (BuildContext context, String newValue, Widget? child) {
              return Text(
                newValue,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              );
            }),
      ],
    );
  }
}
