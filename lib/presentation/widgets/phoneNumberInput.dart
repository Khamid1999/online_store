import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class PhoneNumberInput extends StatelessWidget {
  final TextEditingController? numberController;
  final String? Function(String?)? validator;
  final PhoneNumber? number;
  PhoneNumberInput({this.numberController, this.validator, this.number});
  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      selectorTextStyle: TextStyle(color: Colors.black),
      initialValue:number,
      textFieldController: numberController,
      formatInput: false,
      validator: validator,
      keyboardType:TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: OutlineInputBorder(),
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }
}
