import '../style/constant.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'input_container.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({
    Key key,
    @required this.icon,
    @required this.hint,
    this.textController,
    this.textType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final textController;
  final TextInputType textType;
  final List<FieldValidator<dynamic>> validator;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        cursorColor: kPrimaryColor,
        controller: textController,
        validator: MultiValidator(validator),
        keyboardType: textType,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

