import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nt_sixth_exam/ui/screens/all_cards/widget/card_info.dart';
import 'package:nt_sixth_exam/utils/colors.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class MyFormField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final TextInputAction textInputAction;
  final TextInputType inputType;

  const MyFormField({
    Key? key,
    required this.controller,
    required this.title,
    required this.textInputAction,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(widget.title),
          ),
          const SizedBox(height: 7),
          TextFormField(
            keyboardType: widget.inputType,
            inputFormatters: widget.title == "Karta raqami"
                ? [CreditCardFormatter(), LengthLimitingTextInputFormatter(19)]
                : widget.title == "Amal qilish muddati"
                    ? [
                        CardExpirationFormatter(),
                        LengthLimitingTextInputFormatter(5)
                      ]
                    : [],
            onChanged: (s) {
              if (widget.title == "Karta raqami") {
                CardInfo.numberValue.value = s;
              } else if (widget.title == "Amal qilish muddati") {
                CardInfo.dateValue.value = s;
                if (s.length == 5) {
                  if (DateTime.now().year.toString() == "20${s.substring(3)}") {
                    if (DateTime.now().month >= int.parse(s.substring(0, 2))) {
                      setState(() => isError = true);
                    }
                  } else if (DateTime.now().year >
                      int.parse("20${s.substring(3)}")) {
                    setState(() => isError = true);
                  } else if (int.parse(s.substring(0, 2)) > 12) {
                    setState(() => isError = true);
                  }
                } else {
                  setState(() => isError = false);
                }
              } else if (widget.title == "Karta nomi") {
                CardInfo.nameValue.value = s;
              } else if (widget.title == "Karta egasining to'liq ism sharifi") {
                CardInfo.ownerValue.value = s;
              }
            },
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.title,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: MyColors.othersDark4)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: isError ? MyColors.error : MyColors.othersDark4)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: isError ? MyColors.error : MyColors.othersDark4)),
            ),
          ),
        ],
      ),
    );
  }
}

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}
