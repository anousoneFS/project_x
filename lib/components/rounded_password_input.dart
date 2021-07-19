import '../style/constant.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'input_container.dart';

class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput({
    Key key,
    @required this.icon,
    @required this.hint,
    this.textController,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final textController;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        controller: textController,
        cursorColor: kPrimaryColor,
        validator: RequiredValidator(errorText: "ກະລຸນາປ້ອນລະຫັດຜ່ານ"),
        obscureText: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hint,
          hintStyle: TextStyle(fontFamily: 'NotoSansLao',),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

